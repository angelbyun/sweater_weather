require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email}
    it { should validate_presence_of :password_digest }

    it { should have_secure_password }

    it "validates the validations" do
      user = User.create!(email: "angelbyun123@gmail.com", password: "test", password_confirmation: "test", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq("test")

      expect(user.api_key).to be_a(String)
      expect(user.api_key.length).to eq(20)
    end
  end
end
