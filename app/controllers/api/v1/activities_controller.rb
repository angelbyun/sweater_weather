class Api::V1::ActivitiesController < ApplicationController
  def search
    @activities = ActivitiesFacade.new(params[:destination]).get_activity
    render json: ActivitiesSerializer.new(@activities)
  end

  private
  def activities_params
    params.permit(:destination)
  end
end