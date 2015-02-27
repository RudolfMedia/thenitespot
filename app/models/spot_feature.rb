class SpotFeature < ActiveRecord::Base
  belongs_to :spot
  belongs_to :feature

  validates_presence_of :spot, :feature 
  validates_uniqueness_of :spot_id, scope: :feature_id 
end
