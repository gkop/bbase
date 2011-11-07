module ApplicationHelper

  def maybe_load(callback, *js_files)
    if !js_files.empty?
      js_files.map! do |f|
        f = "\'#{request.protocol + request.host_with_port}/javascripts/#{f}\'"
      end
      raw "BBase.maybeLoad(\"#{callback ? callback : 'null'}\", #{js_files * ', '});"
    end
  end

  def tiny_image(artwork)
    image_tag(artwork.image.tiny.url, :size => "48x48")
  end
  
  def thumb_image(artwork)
    image_tag(artwork.image.thumb.url, :width => 72)
  end
  
  def bigtoe_image(artwork)
    image_tag(artwork.image.bigtoe.url, :width => 128)
  end
  
  def collage_image(artwork)
    image_tag(artwork.image.collage.url, :width => 256)
  end
  
  def square_image(artwork)
    image_tag(artwork.image.square.url)
  end
  
  def slideshow_image(artwork)
    image_tag(artwork.image.slideshow.url, :width => 774)
  end

end
