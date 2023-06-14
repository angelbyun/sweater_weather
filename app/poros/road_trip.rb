class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, travel_time, forecast)
    @start_city = origin
    @end_city = destination
    @travel_time = travel_time == nil ? "Impossible Route" : travel_time
    @weather_at_eta = forecast
  end
end