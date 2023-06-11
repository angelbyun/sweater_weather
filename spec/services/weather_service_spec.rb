require 'rails_helper'

RSpec.describe WeatherService do
  describe "#current_weather" do
    it "returns a list of attributes for the current weather for a specific city" do
      weather_service = WeatherService.new.current_weather("39.74001,-104.99202")

      expect(weather_service).to be_a(Hash)
      expect(weather_service[:current]).to be_a(Hash)

      weather_data = weather_service[:current]
      
      expect(weather_data).to have_key(:last_updated)
      expect(weather_data[:last_updated]).to be_a(String)
      expect(weather_data).to have_key(:temp_f)
      expect(weather_data[:temp_f]).to be_a(Float)
      expect(weather_data).to have_key(:feelslike_f)
      expect(weather_data[:feelslike_f]).to be_a(Float)
      expect(weather_data).to have_key(:humidity)
      expect(weather_data[:humidity]).to be_a(Integer)
      expect(weather_data).to have_key(:uv)
      expect(weather_data[:uv]).to be_a(Float)
      expect(weather_data).to have_key(:vis_miles)
      expect(weather_data[:vis_miles]).to be_a(Float)
      expect(weather_data).to have_key(:condition)
      expect(weather_data[:condition][:text]).to be_a(String)
      expect(weather_data).to have_key(:condition)
      expect(weather_data[:condition][:icon]).to be_a(String)
    end
  end
end