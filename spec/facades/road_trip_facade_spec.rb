require 'rails_helper'

RSpec.describe "Road Trip Facade", :vcr do
  describe "#get_distance" do
    it "returns a road trip object" do
      origin = "Denver,CO"
      destination = "Boulder,CO"

      road_trip = RoadTripFacade.new.road_trip(origin, destination)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to eq("Denver,CO")
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(Hash)
    end

    it "returns 'Impossible Route' when a road trip cannot happen" do
      origin = "Denver,CO"
      destination = "Tokyo,JP"

      road_trip = RoadTripFacade.new.road_trip(origin, destination)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.travel_time).to eq("Impossible Route")
    end
  end
end