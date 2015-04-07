# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  after :remove, :delete_empty_upstream_dirs
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  def store_dir
   "#{base_store_dir}/#{model.id}"
  end

  def base_store_dir
   "images/#{model.created_at.strftime('%j')}"
  end

  # 'images/spot/2123'
  # 'images/spot/421/5421'
    
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  process resize_to_fit: [ 640, 640 ]
  
  # user ...
  # - original >  portrate / landscape 
  # -- process resize_to_fit: [640, 640]

  version :avatar, if: :is_profile_model? do 

    process :resize_to_fill => [ 160, 160 ]  # retna version! > crop  > small from cropped medium    

    version :small do
      process :resize_to_fill => [ 80, 80 ]
    end
  end

  # 3:2 .. 640x427 ... 1280x853... 320x213 160x107 80x53

  version :thumb, if: :is_spot_or_event? do 

    process :resize_to_fill => [ 320, 213 ] # retna version! > crop

    version :small do 
      process :resize_to_fill => [ 160, 107 ]
    end

  end

  # version :background, if: :is_background_image? do 
  #   process :resize_to_fill => [ 1280 , 853 ] ## !manipulate!.........
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir

    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end

private 

  def is_background_image? image 
   model.is_bg?
  end

  def is_profile_model? image
   model.imageable_type == 'Profile'
  end

  def is_spot_or_event? image 
   model.imageable_type == ( 'Spot' || 'Event' )
  end

end
