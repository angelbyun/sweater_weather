class RoadTripService
  def get_distance(origin, destination)
    get_url("/directions/v2/route?from=#{origin}&to=#{destination}")
  end

  private
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |faraday|
      faraday.params['key'] = ENV['GEOCODE_API']
    end
  end
end