class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :spot

  attr_accessor :ll 

  validates_presence_of :user_id, :spot_id, :ll 
  validate :user_close_enough?, :within_12_hours?


private

  def user_position
   return unless ll 
   ll.split(',')
  end

  def user_close_enough?
   unless Geocoder::Calculations.distance_between(spot.to_coordinates, user_position) < 0.310
    errors.add(:base, 'Unable to checkin at this location')
   end
  end

  def within_12_hours?
   return unless user_has_checked_in_before?
   if last_user_checkin.created_at > 12.hours.ago(Time.now)
    errors.add(:base, 'One checkin a day')
   end
  end

  def user_has_checked_in_before?
    Checkin.exists?(user_id: user_id, spot_id: spot_id)
  end

  def last_user_checkin
    Checkin.where(user_id: user_id, spot_id: spot_id).order(created_at: :desc).first 
  end

end
