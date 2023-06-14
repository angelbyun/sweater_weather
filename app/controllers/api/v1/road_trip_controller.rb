class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      road_trip = RoadTripFacade.new.road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { error: "Unauthorized" }, status: 401
    end
  end
end