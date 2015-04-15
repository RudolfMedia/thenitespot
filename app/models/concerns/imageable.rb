module Imageable 
  extend ActiveSupport::Concern
  
  included do 
    has_many :images, as: :imageable, dependent: :destroy 
    with_options as: :imageable, class_name: 'Image' do 
      has_one  :primary_image,    ->{ primary  }
      has_one  :background_image, ->{ background }
    end
  end
end