class Category < ActiveRecord::Base
    include Sortable

    has_many :categorizations
    has_many :spots, through: :categorizations, source: :categorizable, source_type: 'Spot'   

	validates_presence_of :name

	def to_s
      name.titleize 
	end
end
