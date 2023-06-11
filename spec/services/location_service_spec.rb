require 'rails_helper'

RSpec.describe LocationService do
  describe "#get_lat_lon" do
    it "returns the latitude and longitude of a city/state" do
      location_service = LocationService.new.get_lat_lon("Denver,CO")

      expect(location_service).to be_a(Hash)
      expect(location_service[:results]).to be_an(Array)

      location_data = location_service[:results].first

      expect(location_data[:providedLocation]).to be_a(Hash)
      expect(location_data[:providedLocation][:location]).to eq("Denver,CO")

      expect(location_data[:locations]).to be_an(Array)
      expect(location_data[:locations].first).to be_a(Hash)
      expect(location_data[:locations].first).to have_key(:latLng)

      lat_lon = location_data[:locations].first[:latLng]

      expect(lat_lon).to have_key(:lat)
      expect(lat_lon).to have_key(:lng)
      expect(lat_lon[:lat]).to be_a(Float)
      expect(lat_lon[:lat]).to eq(39.74001)
      expect(lat_lon[:lng]).to be_a(Float)
      expect(lat_lon[:lng]).to eq(-104.99202)
    end
  end
end