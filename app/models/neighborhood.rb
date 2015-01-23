class Neighborhood < ActiveRecord::Base
	# geocoded_by :address
	# before_validation :gecode, if: ->(n){ n.address.present && ( n.name_changed? || b.state_changed? }
    # has_many :spots
	
	validates :state, presence: true, length: { is: 2 }
	validates :name, presence: true, length: { in: 2..50 }
	validates_presence_of :longitude, :latitude, message: 'Unable to geocode specified location'
	validates_numericality_of :longitude, :latitude 

	before_save :default_label, if: ->(n){ n.label.blank? }

	def address
	  [ name, state ].join(', ').titleize
	end

private

	def default_label
	  self.label = name.titleize  
	end

end
