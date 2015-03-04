class Menu < ActiveRecord::Base
  include Sortable 

  belongs_to :spot
  has_many :sections, class_name: 'MenuSection', dependent: :destroy
  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :spot_id 
  validates :name, length: { maximum: 50 }, allow_blank: true 
  validates :description, length: { maximum: 250 }, allow_blank: true 
  
end
