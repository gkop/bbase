module ArtworksHelper

  def basic_title(artwork)
    "#{artwork.title} (#{year_for(artwork)})"
  end

  def year_for(artwork)
    "#{(artwork.numeric_year.present? ? artwork.numeric_year : (artwork.string_year.present? ? artwork.string_year : "?"))}"
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

  def next_artwork_in_gallery_link
    next_artwork = @gallery.next_artwork_after(@artwork)
    link_to "Next artwork: #{next_artwork.title}", gallery_artwork_path(gallery_id: @gallery.id, id: next_artwork.id)
  end
end
