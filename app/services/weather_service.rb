class WeatherService
  def current_weather(search)
    get_url("current.json?&q=#{search}")
  end

  private
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://api.weatherapi.com/v1/') do |faraday|
      faraday.params['key'] = ENV['WEATHER_API']
    end
  end
end