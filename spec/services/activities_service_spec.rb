require 'rails_helper'

RSpec.describe ActivitiesService do
  describe "#list_activity" do
    it "returns an activity based upon type" do
      activity_service = ActivitiesService.new.list_activity("relaxation")

      expect(activity_service).to be_a(Hash)
      expect(activity_service).to have_key(:activity)
      expect(activity_service[:activity]).to be_a(String)
      expect(activity_service).to have_key(:type)
      expect(activity_service[:type]).to be_a(String)
      expect(activity_service).to have_key(:participants)
      expect(activity_service[:participants]).to be_an(Integer)
      expect(activity_service).to have_key(:price)
      expect(activity_service[:price]).to be_a(Float)
    end
  end
end