module ArtworksHelper

  def basic_title(artwork)
    artwork.title+" ("+(artwork.year ? artwork.year.to_s : "?")+")"
  end
 
end
