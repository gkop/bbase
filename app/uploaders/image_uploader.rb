# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :grid_fs
  # storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
     "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # TODO: resize proportionately on some of these
  version :economy do
    process :resize_to_fill => [512, 512]
  end

  version :collage do
    process :resize_to_fill => [256, 256]
  end

  version :bigtoe do
    process :resize_to_fill => [128, 128]
  end

  version :thumb do
    process :resize_to_fill => [72, 72]
  end
  
  version :tiny do
    process :resize_to_fill => [36, 36]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png bmp)
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end

end
