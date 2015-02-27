class Feature < ActiveRecord::Base
    has_many :spot_features, dependent: :destroy
    has_many :spots, through: :spot_features

	validates_presence_of :name 
	default_scope { order(:name) }

	def to_s
  	  name.titleize 
	end
	
end
