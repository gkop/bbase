module ApplicationHelper

  # render img tags with the correct demensions
  ["slideshow", "square", "collage", "bigtoe", "thumb", "tiny"].each do |version|
    define_method("#{version}_image".to_s) do |artwork|
      size_options = {}
      ["width", "height"].each do |dimension|
        value = artwork.send("image_#{version}_#{dimension}".to_sym)
        size_options[dimension.to_sym] = value if value
      end
      image_tag(artwork.image.send(version.to_sym).url, size_options)
    end
  end
  
end
