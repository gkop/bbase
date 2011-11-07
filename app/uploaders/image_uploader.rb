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
  process :record_version_dimensions

  # Create different versions of your uploaded files:
  version :slideshow do
    process :resize_to_fill => [774, 500]
    process :record_version_dimensions => :slideshow
  end

  version :square do
    process :resize_to_limit => [512, 512]
    process :record_version_dimensions => :square
  end

  version :collage do
    process :resize_to_limit => [256, 5000]
    process :record_version_dimensions => :collage
  end

  version :bigtoe do
    process :resize_to_limit => [128, 5000]
    process :record_version_dimensions => :bigtoe
  end

  version :thumb do
    process :resize_to_limit => [72, 5000]
    process :record_version_dimensions => :thumb
  end
  
  version :tiny do
    process :resize_to_fill => [48, 48]
    process :record_version_dimensions => :tiny
  end

  def record_version_dimensions(version=nil)
    width, height = `identify -format "%wx%h" #{file.path}`.gsub("\n", "").split(/x/)    
    self.model.send("image_#{version.to_s+"_" if version}width=", width.to_i)
    self.model.send("image_#{version.to_s+"_" if version}height=", height.to_i)
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
