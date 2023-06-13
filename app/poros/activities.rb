class Activities
  attr_reader :destination,
              :forecast,
              :activities

  def initialize(location, forecast, list_of_activities)
    @destination = location
    @forecast = forecast
    @activities = list_of_activities
  end
end