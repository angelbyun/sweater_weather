class RoadTripFacade < ForecastFacade
  # def initialize(origin, destination)
  #   @origin = origin
  #   @destination = destination
  # end

  def road_trip(origin, destination)
    travel_time = road_trip_service.get_distance(origin, destination)
    if travel_time[:route].has_key?(:routeError)
      RoadTrip.new(origin, destination, nil, {})
    else
      eta = travel_time[:route][:formattedTime]
      # real_time = travel_time[:route][:realTime]
      eta_array = eta.split(":").map(&:to_i)
      arrival_time = Time.now + eta_array[0].hours + eta_array[1].minutes + eta_array[2].seconds
      forecast = get_future_weather(destination, arrival_time)
      RoadTrip.new(origin, destination, eta, forecast)
    end
  end

  private
  # def arrival_time(eta)
  #   Time.now + eta.to_i
  # end

  def get_future_weather(destination, arrival_time)
    date = arrival_time.strftime('%Y-%m-%d')
    hour = arrival_time.strftime('%H')
    weather = WeatherService.new.get_future_weather(destination, date, hour)
    {
      datetime: weather[:forecast][:forecastday].first[:hour].first[:time],
      temperature: weather[:forecast][:forecastday].first[:hour].first[:temp_f],
      condition: weather[:forecast][:forecastday].first[:day][:condition][:text]
    }
  end

  def road_trip_service
    @_road_trip_service ||= RoadTripService.new
  end
end