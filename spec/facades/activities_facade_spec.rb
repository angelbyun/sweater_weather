require 'rails_helper'

RSpec.describe ActivitiesFacade do
  describe "instance methods" do
    before :each do
      @location = "Chicago,IL"
      @type = "relaxation", "recreational"
      @activity_facade = ActivitiesFacade.new(@location)
    end

    describe "#get_activity" do
      it "returns an Activity Object" do
        expect(@activity_facade).to be_an(ActivitiesFacade)

        expect(@activity_facade.get_activity).to be_an(Activities)

        expect(@activity_facade.get_activity.destination).to eq(@location)

        expect(@activity_facade.get_activity.forecast).to be_a(Hash)
        expect(@activity_facade.get_activity.forecast).to have_key(:summary)
        expect(@activity_facade.get_activity.forecast[:summary]).to be_a(String)
        expect(@activity_facade.get_activity.forecast).to have_key(:temperature)
        expect(@activity_facade.get_activity.forecast[:temperature]).to be_a(Float)

        expect(@activity_facade.get_activity.activities).to be_an(Array)
        expect(@activity_facade.get_activity.activities.count).to eq(2)

        activity_data = @activity_facade.get_activity.activities.first

        expect(activity_data).to be_an(Activity)
        expect(activity_data.activity).to be_a(String)
        expect(activity_data.type).to be_a(String)
        expect(activity_data.participants).to be_an(Integer)
        expect(activity_data.price).to be_a(Float)
      end
    end
  end
end