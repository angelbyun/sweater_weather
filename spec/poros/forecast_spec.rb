require 'rails_helper'

RSpec.describe Forecast, :vcr do
  it 'exists and has attributes' do
    forecast = ForecastFacade.new.get_forecast("Denver,CO")

    expect(forecast).to be_a(Forecast)

    current_weather = forecast.current_weather

    expect(current_weather).to have_key(:last_update)
    expect(current_weather[:last_update]).to be_a(String)
    expect(current_weather).to have_key(:temp)
    expect(current_weather[:temp]).to be_a(Float)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to be_a(Integer)
    expect(current_weather).to have_key(:uv)
    expect(current_weather[:uv]).to be_a(Float)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather[:visibility]).to be_a(Float)
    expect(current_weather).to have_key(:text)
    expect(current_weather[:text]).to be_a(String)
    expect(current_weather).to have_key(:icon)
    expect(current_weather[:icon]).to be_a(String)

    daily_weather = forecast.daily_weather

    expect(daily_weather.first).to have_key(:date)
    expect(daily_weather.first[:date]).to be_a(String)
    expect(daily_weather.first).to have_key(:sunrise)
    expect(daily_weather.first[:sunrise]).to be_a(String)
    expect(daily_weather.first).to have_key(:sunset)
    expect(daily_weather.first[:sunset]).to be_a(String)
    expect(daily_weather.first).to have_key(:max_temp)
    expect(daily_weather.first[:max_temp]).to be_a(Float)
    expect(daily_weather.first).to have_key(:min_temp)
    expect(daily_weather.first[:min_temp]).to be_a(Float)
    expect(daily_weather.first).to have_key(:text)
    expect(daily_weather.first[:text]).to be_a(String)
    expect(daily_weather.first).to have_key(:icon)
    expect(daily_weather.first[:icon]).to be_a(String)

    hourly_weather = forecast.hourly_weather

    expect(hourly_weather.first).to have_key(:time)
    expect(hourly_weather.first[:time]).to be_a(String)
    expect(hourly_weather.first).to have_key(:temp)
    expect(hourly_weather.first[:temp]).to be_a(Float)
    expect(hourly_weather.first).to have_key(:text)
    expect(hourly_weather.first[:text]).to be_a(String)
    expect(hourly_weather.first).to have_key(:icon)
    expect(hourly_weather.first[:icon]).to be_a(String)
  end
end