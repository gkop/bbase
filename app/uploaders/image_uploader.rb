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

  # TODO: convert all files to png

  # Create different versions of your uploaded files:
  version :economy do
    process :resize_to_limit => [512, 5000]
  end

  version :collage do
    process :resize_to_limit => [256, 5000]
  end

  version :bigtoe do
    process :resize_to_limit => [128, 5000]
  end

  version :thumb do
    process :resize_to_limit => [72, 5000]
  end
  
  version :tiny do
    process :resize_to_fill => [48, 48]
  end

  # I want to be able to process after uploading as described in this message
  #  http://groups.google.com/group/carrierwave/msg/5a73ee0dcc17e402
  def resize_later
    resize_to_fill(200, 200)
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
