module Categorizable
  extend ActiveSupport::Concern

  included do 
    has_many :categorizations, as: :categorizable, dependent: :destroy
    has_many :categories, through: :categorizations
    has_many :subcategories, through: :categories 
  end

end