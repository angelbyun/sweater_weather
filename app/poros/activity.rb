class Activity
  attr_reader :activity,
              :type,
              :participants,
              :price

  def initialize(activity_data)
    @activity = activity_data[:activity]
    @type = activity_data[:type]
    @participants = activity_data[:participants]
    @price = activity_data[:price].to_f
  end
end