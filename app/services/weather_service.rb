class WeatherService
  def get_weather(location)
    get_url("/v1/forecast.json?&days=5&q=#{location}")
  end

  def get_future_weather(location, date, hour)
    # require 'pry'; binding.pry
    get_url("/v1/forecast.json?q=#{location}&dt=#{date}&hour=#{hour}")
  end

  private
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://api.weatherapi.com') do |faraday|
      faraday.params['key'] = ENV['WEATHER_API']
    end
  end
end