require 'rails_helper'

RSpec.describe WeatherService do
  describe "#get_weather" do
    it "returns a list of attributes for the current weather for a specific city" do
      current_weather = WeatherService.new.get_weather("39.74001","-104.99202")

      expect(current_weather).to be_a(Hash)
      expect(current_weather[:current]).to be_a(Hash)

      current_weather_data = current_weather[:current]
      
      expect(current_weather_data).to have_key(:last_updated)
      expect(current_weather_data[:last_updated]).to be_a(String)
      expect(current_weather_data).to have_key(:temp_f)
      expect(current_weather_data[:temp_f]).to be_a(Float)
      expect(current_weather_data).to have_key(:feelslike_f)
      expect(current_weather_data[:feelslike_f]).to be_a(Float)
      expect(current_weather_data).to have_key(:humidity)
      expect(current_weather_data[:humidity]).to be_a(Integer)
      expect(current_weather_data).to have_key(:uv)
      expect(current_weather_data[:uv]).to be_a(Float)
      expect(current_weather_data).to have_key(:vis_miles)
      expect(current_weather_data[:vis_miles]).to be_a(Float)
      expect(current_weather_data).to have_key(:condition)
      expect(current_weather_data[:condition][:text]).to be_a(String)
      expect(current_weather_data).to have_key(:condition)
      expect(current_weather_data[:condition][:icon]).to be_a(String)
    end

    it "returns the forecast for 5 days for a specific city" do
      daily_weather = WeatherService.new.get_weather("39.74001","-104.99202")

      expect(daily_weather[:forecast]).to be_a(Hash)
      expect(daily_weather[:forecast][:forecastday].count).to eq(5)

      daily_weather_data = daily_weather[:forecast][:forecastday].first

      expect(daily_weather_data).to have_key(:date)
      expect(daily_weather_data[:date]).to be_a(String)
      expect(daily_weather_data[:astro]).to have_key(:sunrise)
      expect(daily_weather_data[:astro][:sunrise]).to be_a(String)
      expect(daily_weather_data[:astro]).to have_key(:sunset)
      expect(daily_weather_data[:astro][:sunset]).to be_a(String)
      expect(daily_weather_data[:day]).to have_key(:maxtemp_f)
      expect(daily_weather_data[:day][:maxtemp_f]).to be_a(Float)
      expect(daily_weather_data[:day]).to have_key(:mintemp_f)
      expect(daily_weather_data[:day][:mintemp_f]).to be_a(Float)
      expect(daily_weather_data[:day]).to have_key(:condition)
      expect(daily_weather_data[:day][:condition]).to be_a(Hash)
      expect(daily_weather_data[:day][:condition]).to have_key(:text)
      expect(daily_weather_data[:day][:condition][:text]).to be_a(String)
      expect(daily_weather_data[:day][:condition]).to have_key(:icon)
      expect(daily_weather_data[:day][:condition][:icon]).to be_a(String)
    end

    it "returns the hourly forecast for a specific city" do
      hourly_weather = WeatherService.new.get_weather("39.74001","-104.99202")

      expect(hourly_weather[:forecast][:forecastday]).to be_an(Array)
      expect(hourly_weather[:forecast][:forecastday].first).to have_key(:hour)
      expect(hourly_weather[:forecast][:forecastday].first[:hour].count).to eq(24)

      hourly_weather[:forecast][:forecastday].each do |hourly_weather_data|
        expect(hourly_weather_data).to have_key(:hour)
        expect(hourly_weather_data[:hour]).to be_an(Array)
        expect(hourly_weather_data[:hour].first).to have_key(:time)
        expect(hourly_weather_data[:hour].first[:time]).to be_a(String)
        expect(hourly_weather_data[:hour].first).to have_key(:temp_f)
        expect(hourly_weather_data[:hour].first[:temp_f]).to be_a(Float)
        expect(hourly_weather_data[:hour].first).to have_key(:condition)
        expect(hourly_weather_data[:hour].first[:condition]).to be_a(Hash)
        expect(hourly_weather_data[:hour].first[:condition]).to have_key(:text)
        expect(hourly_weather_data[:hour].first[:condition][:text]).to be_a(String)
        expect(hourly_weather_data[:hour].first[:condition]).to have_key(:icon)
        expect(hourly_weather_data[:hour].first[:condition][:icon]).to be_a(String)
      end
    end
  end
end