class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  after :remove, :delete_empty_upstream_dirs

  def store_dir
   "#{base_store_dir}/#{model.id}"
  end

  def base_store_dir
   "images/#{model.class.to_s.underscore}/#{model.avatar_identifier[0,2]}"
  end

  process resize_to_fit: [ 640, 640 ]

  version :large do  # from_version: :cropped ? 
    process :resize_to_fill => [ 320, 320 ] # display @160 x 160     
  end

  version :medium do # from_version :large
    process :resize_to_fill => [ 160, 160 ] # display @80 x 80
  end

  version :small do # from_version :medium
    process :resize_to_fill => [ 80, 80 ] # display @40 x 40?
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

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path)

    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path) 
  rescue SystemCallError
    true 
  end

end
