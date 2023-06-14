require 'rails_helper'

RSpec.describe "User Login", :vcr do
  describe "user login" do
    it "allows existing users to login" do
      user = User.create!(email: "angelbyun123@gmail.com", password: "test", password_confirmation: "test")
      user_login_params = { 
                email: "angelbyun123@gmail.com",
                password: "test"
              }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_login_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      user_login = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(user_login).to be_a(Hash)
      expect(user_login[:attributes]).to have_key(:email)
      expect(user_login[:attributes][:email]).to be_a(String)
      expect(user_login[:attributes]).to have_key(:api_key)
      expect(user_login[:attributes][:api_key]).to be_a(String)
    end

    it "displays error message when password does not match" do
      user = User.create!(email: "angelbyun123@gmail.com", password: "test", password_confirmation: "test")
      user_login_params = { 
                email: "angelbyun123@gmail.com",
                password: "12345"
              }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_login_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:error]).to eq("Invalid input - please try again!")
    end

    it "displays error message when email does not match" do
      user = User.create!(email: "angelbyun123@gmail.com", password: "test", password_confirmation: "test")
      user_login_params = { 
                email: "angelbyun@gmail.com",
                password: "test"
              }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_login_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:error]).to eq("Invalid input - please try again!")
    end
  end
end