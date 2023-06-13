class ActivitiesFacade
  def initialize(location, type)
    @destination = location
    @type = type
  end

  def get_activity
    Activities.new(@destination, forecast, list_of_activities)
  end

  private
  def list_of_activities
    activity_search.map do |activity|
      Activity.new(activity)
    end
  end

  def forecast
    {
      summary: current_weather[:text],
      temperature: current_weather[:temp]
    }
  end

  def current_weather
    forecast_info.current_weather
  end

  def forecast_info
    @_forecast ||= ForecastFacade.new.get_forecast(@destination)
  end

  def activity_search
    @_activity_search ||= @type.map do |type|
      service.list_activity(type)
    end
  end

  def service
    @_service ||= ActivitiesService.new
  end
end