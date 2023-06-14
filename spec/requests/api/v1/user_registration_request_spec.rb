require 'rails_helper'

RSpec.describe "User Registration", :vcr do
  describe "user registration" do
    it "allows new users to register" do
      users = { 
                email: "angelbyun123@gmail.com",
                password: "test", 
                password_confirmation: "test" 
              }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/users", headers: headers, params: JSON.generate(users)
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      user_registration = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(user_registration).to be_a(Hash)

      expect(user_registration[:attributes]).to have_key(:email)
      expect(user_registration[:attributes][:email]).to be_a(String)
      expect(user_registration[:attributes]).to have_key(:api_key)
      expect(user_registration[:attributes][:api_key]).to be_a(String)
      expect(user_registration[:attributes][:api_key].length).to eq(20)
    end

    it "displays error message when passwords do not match" do
      users = { 
                email: "angelbyun123@gmail.com",
                password: "test", 
                password_confirmation: "12345" 
              }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/users", headers: headers, params: JSON.generate(users)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:error]).to eq("Validation failed: Password confirmation doesn't match Password")
    end

    it "displays error message when email is left blank" do
      users = { 
                email: "",
                password: "test", 
                password_confirmation: "test" 
              }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/users", headers: headers, params: JSON.generate(users)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)
      
      expect(error[:error]).to eq("Validation failed: Email can't be blank")
    end
  end
end