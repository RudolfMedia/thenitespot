class Categorization < ActiveRecord::Base
	belongs_to :categorizable, polymorphic: true
	belongs_to :category

	validates_uniqueness_of :category_id, scope: [:categorizable_id, :categorizable_type]
end
