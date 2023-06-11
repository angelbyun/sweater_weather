require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes' do
    forecast = ForecastFacade.new.get_forecast("Denver,CO")

    expect(forecast).to be_a(Forecast)

    current_weather = forecast.current_weather.to be_a(Hash)

    expect(current_weather).to have_key(:last_updated)
    expect(current_weather[:last_update]).to be_a(String)
    expect(current_weather).to have_key(:temp_f)
    expect(current_weather[:temp_f]).to be_a(Float)
    expect(current_weather).to have_key(:feelslike_f)
    expect(current_weather[:feelslike_f]).to be_a(Float)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to be_a(Integer)
    expect(current_weather).to have_key(:uv)
    expect(current_weather[:uv]).to be_a(Float)
    expect(current_weather).to have_key(:vis_miles)
    expect(current_weather[:vis_miles]).to be_a(Float)
    expect(current_weather).to have_key(:condition)
    current_con = current_weather[:condition]
    expect(current_con[:text]).to be_a(String)
    expect(current_weather).to have_key(:condition)
    expect(ccurrent_con[:icon]).to be_a(String)

    daily_weather = forecast.daily_weather.to be_an(Array)

    expect(daily_weather).to have_key(:date)
    expect(daily_weather[:date]).to be_a(String)

    daily_weather[:astro].each do |daily|
      expect(daily).to have_key(:sunrise)
      expect(daily[:sunrise]).to be_a(String)
      expect(daily).to have_key(:sunset)
      expect(daily[:sunset]).to be_a(String)
    end

    daily_weather[:day].each do |daily|
      expect(daily).to have_key(:maxtemp_f)
      expect(daily[:maxtemp_f]).to be_a(Float)
      expect(daily).to have_key(:mintemp_f)
      expect(daily[:mintemp_f]).to be_a(Float)
      expect(daily).to have_key(:condition)
      daily_con = daily[:condition]
      expect(daily_con).to be_a(Hash)
      expect(daily_con).to have_key(:text)
      expect(daily_con[:text]).to be_a(String)
      expect(daily_con).to have_key(:icon)
      expect(daily_con[:icon]).to be_a(String)
    end

    hourly_weather = forecast.hourly_weather.to be_an(Array)

    expect(hourly_weather[:forecast][:forecastday].first).to have_key(:hour)
    expect(hourly_weather[:forecast][:forecastday].first[:hour]).to be_a(Hash)

    hourly_weather[:forecast][:forecastday].first[:hour].each do |hourly|
      expect(hourly).to have_key(:hour)
      expect(hourly).to be_an(Array)
      expect(hourly).to have_key(:time)
      expect(hourly[:time]).to be_a(String)
      expect(hourly).to have_key(:temp_f)
      expect(hourly[:temp_f]).to be_a(Float)
      expect(hourly).to have_key(:condition)
      hourly_con = hourly[:condition]
      expect(hourly_con).to be_a(Hash)
      expect(hourly_con).to have_key(:text)
      expect(hourly_con[:text]).to be_a(String)
      expect(hourly_con).to have_key(:icon)
      expect(hourly_con[:icon]).to be_a(String)
    end
  end
end