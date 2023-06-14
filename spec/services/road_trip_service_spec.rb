require 'rails_helper'

RSpec.describe RoadTripService, :vcr do
  describe "#get_distance" do
    it "returns the distance for a given origin and destination" do
      origin = "Denver,CO"
      destination = "Boulder,CO"

      distance_service = RoadTripService.new.get_distance(origin, destination)

      expect(distance_service).to be_a(Hash)
      expect(distance_service).to have_key(:route)
      expect(distance_service[:route]).to have_key(:formattedTime)
      expect(distance_service[:route][:formattedTime]).to be_a(String)
    end
  end
end