class ForecastFacade
  def get_forecast(lat_lon)
    location = location_service.get_lat_lon(lat_lon)
    lat = location[:results].first[:locations].first[:latLng][:lat]
    lon = location[:results].first[:locations].first[:latLng][:lon]

    weather = weather_service.get_weather(lat,lon)
    current_weather = get_current_weather(weather)
    daily_weather = get_daily_weather(weather)
    hourly_weather = get_hourly_weather(weather)

    Forecast.new(current_weather, daily_weather, hourly_weather)
  end

  private
  def get_current_weather(weather)
    {
      last_update: weather[:current][:last_updated],
      temp: weather[:current][:temp_f],
      feels_like: weather[:current][:feelslike_f],
      humidity: weather[:current][:humidity],
      visibility: weather[:current][:vis_miles],
      text: weather[:current][:condition][:text],
      icon: weather[:current][:condition][:icon]
    }
  end

  def get_daily_weather(weather)
    weather[:forecast][:forecastday].map do |daily|
      {
        date: daily[:date],
        sunrise: daily[:astro][:sunrise],
        sunset: daily[:astro][:sunset],
        max_temp: daily[:day][:maxtemp_f],
        min_temp: daily[:day][:mintemp_f]
      }
    end
  end

  def get_hourly_weather(weather)
    weather[:forecast][:forecastday].first[:hour].map do |hourly|
      {
        time: hourly[:time],
        temp: hourly[:temp_f],
        text: hourly[:condition][:text],
        icon: hourly[:condition][:icon]
      }
    end
  end

  def location_service
    @location_service ||= LocationService.new
  end

  def weather_service
    @weather_service ||= WeatherService.new
  end
end