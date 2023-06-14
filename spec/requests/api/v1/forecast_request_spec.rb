require 'rails_helper'

RSpec.describe "Forecast API", :vcr do
  describe "retrieves the forecast for a city/state" do
    it "retrieves the forecast for a specific city/state" do
      location = "Denver,CO"

      get "/api/v1/forecast?location=#{location}"

      headers = { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecasts = JSON.parse(response.body, symbolize_names: true)[:data]


      expect(forecasts).to be_a(Hash)
      expect(forecasts).to have_key(:id)
      expect(forecasts[:id]).to eq(nil)
      expect(forecasts).to have_key(:type)
      expect(forecasts[:type]).to eq("forecast")
      expect(forecasts[:attributes]).to have_key(:current_weather)
      expect(forecasts[:attributes][:current_weather]).to be_a(Hash)

      current_forecast = forecasts[:attributes][:current_weather]

      expect(current_forecast).to have_key(:last_update)
      expect(current_forecast[:last_update]).to be_a(String)
      expect(current_forecast).to have_key(:temp)
      expect(current_forecast[:temp]).to be_a(Float)
      expect(current_forecast).to have_key(:feels_like)
      expect(current_forecast[:feels_like]).to be_a(Float)
      expect(current_forecast).to have_key(:humidity)
      expect(current_forecast[:humidity]).to be_a(Integer)
      expect(current_forecast).to have_key(:visibility)
      expect(current_forecast[:visibility]).to be_a(Float)
      expect(current_forecast).to have_key(:text)
      expect(current_forecast[:text]).to be_a(String)
      expect(current_forecast).to have_key(:icon)
      expect(current_forecast[:icon]).to be_a(String)

      expect(forecasts[:attributes]).to have_key(:daily_weather)
      expect(forecasts[:attributes][:daily_weather]).to be_a(Array)
      expect(forecasts[:attributes][:daily_weather].first).to be_a(Hash)

      daily_forecast = forecasts[:attributes][:daily_weather].first

      expect(daily_forecast).to have_key(:date)
      expect(daily_forecast[:date]).to be_a(String)
      expect(daily_forecast).to have_key(:sunrise)
      expect(daily_forecast[:sunrise]).to be_a(String)
      expect(daily_forecast).to have_key(:sunset)
      expect(daily_forecast[:sunset]).to be_a(String)
      expect(daily_forecast).to have_key(:max_temp)
      expect(daily_forecast[:max_temp]).to be_a(Float)
      expect(daily_forecast).to have_key(:min_temp)
      expect(daily_forecast[:min_temp]).to be_a(Float)

      expect(forecasts[:attributes]).to have_key(:hourly_weather)
      expect(forecasts[:attributes][:hourly_weather]).to be_a(Array)
      expect(forecasts[:attributes][:hourly_weather].first).to be_a(Hash)

      hourly_forecast = forecasts[:attributes][:hourly_weather].first

      expect(hourly_forecast).to have_key(:time)
      expect(hourly_forecast[:time]).to be_a(String)
      expect(hourly_forecast).to have_key(:temp)
      expect(hourly_forecast[:temp]).to be_a(Float)
      expect(hourly_forecast).to have_key(:text)
      expect(hourly_forecast[:text]).to be_a(String)
      expect(hourly_forecast).to have_key(:icon)
      expect(hourly_forecast[:icon]).to be_a(String)
    end

    it "tests for lack of attributes" do
      location = "Denver,CO"

      get "/api/v1/forecast?location=#{location}"

      headers = { 'CONTENT_TYPE' => 'application/json' }

      forecasts = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      current_forecast = forecasts[:attributes][:current_weather]

      expect(current_forecast).to_not have_key(:last_updated_epoch)
      expect(current_forecast).to_not have_key(:temp_c)
      expect(current_forecast).to_not have_key(:is_day)
      expect(current_forecast).to_not have_key(:code)
      expect(current_forecast).to_not have_key(:wind_mph)

      daily_forecast = forecasts[:attributes][:daily_weather].first

      expect(daily_forecast).to_not have_key(:date_epoch)

      hourly_forecast = forecasts[:attributes][:hourly_weather].first

      expect(hourly_forecast).to_not have_key(:maxtemp_c)
      expect(hourly_forecast).to_not have_key(:mintemp_c)
      expect(hourly_forecast).to_not have_key(:avgtemp_c)
      expect(hourly_forecast).to_not have_key(:maxwind_mph)
      expect(hourly_forecast).to_not have_key(:avgvis_miles)
    end
  end
end