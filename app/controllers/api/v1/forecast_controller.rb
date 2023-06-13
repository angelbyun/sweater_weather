class Api::V1::ForecastController < ApplicationController
  def index
    render json: ForecastSerializer.new(ForecastFacade.new.get_forecast(params[:location]))
  end
end