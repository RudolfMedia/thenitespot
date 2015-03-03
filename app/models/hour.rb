class Hour < ActiveRecord::Base
  include Daily 	
  belongs_to :spot
  
  validates_presence_of :open, :close, :spot_id
  validates_length_of :note, maximum: 200, allow_blank: true 
end
