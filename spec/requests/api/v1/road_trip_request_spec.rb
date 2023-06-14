require 'rails_helper'

RSpec.describe "Create a Road Trip", :vcr do
  describe "retrieves attributes for road trip" do
    it "retrieves attributes for road trip" do
      user = User.create!(email: "angelbyun123@gmail.com", password: "test", password_confirmation: "test")

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/road_trip", headers: headers, params: JSON.generate({ origin: "Denver,CO", destination: "Boulder,CO", api_key: user.api_key })

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(road_trip).to be_a(Hash)
      expect(road_trip).to have_key(:id)
      expect(road_trip[:id]).to eq(nil)
      expect(road_trip).to have_key(:type)
      expect(road_trip[:type]).to eq("road_trip")
      expect(road_trip[:attributes]).to have_key(:weather_at_eta)
      expect(road_trip[:attributes][:weather_at_eta]).to be_a(Hash)
      expect(road_trip[:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(road_trip[:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(road_trip[:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(road_trip[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(road_trip[:attributes][:weather_at_eta]).to have_key(:condition)
      expect(road_trip[:attributes][:weather_at_eta][:condition]).to be_a(String)
    end

    it "displays an error message when api_key does not exist" do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/road_trip", headers: headers, params: JSON.generate({ origin: "Denver,CO", destination: "Boulder,CO", api_key: "No API Key" })

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:error]).to eq("Unauthorized")
    end
  end
end