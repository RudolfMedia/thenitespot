class Image < ActiveRecord::Base
  require 'carrierwave/orm/activeRecord'
  mount_uploader :file, ImageUploader
  belongs_to :imageable, polymorphic: true

  validates_presence_of :imageable_id, :imageable_type, :file 

  before_save :update_imageable_primary, if: ->(img){ img.is_primary? && img.is_primary_changed? }
  before_save :update_collection_background, if: ->(img){ img.is_bg? && img.is_bg_changed? }

private 

  def update_imageable_primary
    imageable_siblings.update_all(is_primary: false)
  end

  def ensure_single_background
    imageable_siblings.update_all(is_bg: false)
  end

  def imageable_siblings
    Image.where(imageable_id: imageable_id, imageable_type: imageable_type).where.not(id: id)
  end

end
