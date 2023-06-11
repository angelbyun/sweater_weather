require 'rails_helper'

RSpec.describe LocationService do
  describe "#get_lat_lon" do
    it "returns the latitude and longitude of a city/state" do
      location_service = LocationService.new.get_lat_lon("Cincinatti,OH")

      expect(location_service).to be_a(Hash)
    end
  end
end