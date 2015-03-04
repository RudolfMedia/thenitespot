class MenuSection < ActiveRecord::Base
  belongs_to :menu
  has_many :items, class_name: 'MenuItem', dependent: :destroy 
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  validates_length_of :name, in: 2..50
  validates_length_of :description, maximum: 250, allow_blank: true 

end
