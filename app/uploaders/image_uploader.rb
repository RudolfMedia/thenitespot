class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  after :remove, :delete_empty_upstream_dirs

  def store_dir
   "#{base_store_dir}/#{model.id}"
  end

  def base_store_dir
   "images/#{model.imageable_type.downcase.underscore}/#{model.file_identifier[0,2]}"
  end

  process resize_to_fit: [ 640, 640 ]
  # 3:2 .. 640x427 ... 1280x853... 320x213 160x107 80x53
  version :thumb do 
    process :resize_to_fill => [ 320, 213 ] # retna version! > crop

    version :small do 
      process :resize_to_fill => [ 160, 107 ]
    end 
  end

  version :background, if: :is_background_image? do 
    process :resize_to_fill => [ 1280 , 853 ] ## !manipulate!.........
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  def extension_white_list
    %w(jpg jpeg png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

protected

  def secure_token
   var = :"@#{mounted_as}_secure_token"
   model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

private 

  def is_background_image? image 
   model.is_bg?
  end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir

    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end

end
