module ArtworksHelper

  def basic_title(artwork)
    artwork.title+" ("+(artwork.year ? artwork.year.to_s : "?")+")"
  end

  def friendly_dimensions(artwork)
    if !artwork.width.blank? && !artwork.height.blank?
      artwork.width.to_s+" x "+artwork.height.to_s
    elsif !artwork.width.blank?
      artwork.width.to_s+" x ?"
    elsif !artwork.height.blank?
      "? x "+artwork.height.to_s
    else
    end
  end
 
end
