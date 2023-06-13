class ActivitiesService
  def list_activity(type)
    get_url("/api/activity?type=#{type}")
  end

  private
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.boredapi.com')
  end
end