require 'rails_helper'

RSpec.describe "Activities API", :vcr do
  describe "displays activities depending on temperature in city/state" do
    it "displays two activities in Chicago, IL" do
      destination = "Chicago,IL"

      get "/api/v1/activities?destination=#{destination}"

      headers = { 'CONTENT_TYPE' => 'application/json' }

      activities = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(activities).to be_a(Hash)
      expect(activities).to have_key(:id)
      expect(activities[:id]).to eq(nil)
      expect(activities).to have_key(:type)
      expect(activities[:type]).to eq("activities")
      expect(activities[:attributes]).to have_key(:destination)
      expect(activities[:attributes][:destination]).to be_a(String)
      expect(activities[:attributes]).to have_key(:forecast)
      expect(activities[:attributes][:forecast][:summary]).to be_a(String)
      expect(activities[:attributes]).to have_key(:forecast)
      expect(activities[:attributes][:forecast][:temperature]).to be_a(Float)
      expect(activities[:attributes][:activities].first).to have_key(:activity)
      expect(activities[:attributes][:activities].first[:activity]).to be_a(String)
      expect(activities[:attributes][:activities].first).to have_key(:type)
      expect(activities[:attributes][:activities].first[:type]).to be_a(String)
      expect(activities[:attributes][:activities].first).to have_key(:participants)
      expect(activities[:attributes][:activities].first[:participants]).to be_an(Integer)
      expect(activities[:attributes][:activities].first).to have_key(:price)
      expect(activities[:attributes][:activities].first[:price]).to be_a(Float)
    end
  end
end