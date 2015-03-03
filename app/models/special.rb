class Special < ActiveRecord::Base
  include Daily 
  include Sortable 
  belongs_to :spot

  validates :name, length: { in: 3..30, wrong_length: 'Must be between 3 and 30 characters' }
  validates :description, length: { maximum: 250, too_long: "%{count} characters is the maximum allowed."}, allow_blank: true 
  validates_presence_of :start_time, :end_time, :spot_id 

end
