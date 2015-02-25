class Category < ActiveRecord::Base
    include Sortable

    has_many :categorizations, dependent: :destroy
    has_many :spots, through: :categorizations, source: 'Spot'

	validates_presence_of :name

	def to_s
      name.titleize 
	end
end
