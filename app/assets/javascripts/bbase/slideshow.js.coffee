Slideshow = {}
Slideshow.init = (galleryData, currentIndex) ->
  @gallery = jQuery.parseJSON(jQuery.unescape(galleryData))
  @index = currentIndex
  self = this
  jQuery("#next a").click (e) ->
    self.timer.stop()
    self.next()
    e.preventDefault()

  jQuery("#previous a").click (e) ->
    self.timer.stop()
    self.previous()
    e.preventDefault()

  @timer = jQuery.timer(->
    self.next()
  )
  @timer.set
    time: 10000
    autostart: true

Slideshow.previous = ->
  Slideshow.show (@index - 1) % @gallery.artworks.length

Slideshow.next = ->
  Slideshow.show (@index + 1) % @gallery.artworks.length

Slideshow.show = (newIndex) ->
  newIndex = @gallery.artworks.length - 1  if newIndex < 0
  artwork = @gallery.artworks[newIndex]
  jImage = jQuery("#slideshow img")
  jImage.fadeOut 1000, ->
    jQuery("a.artwork").attr "href", "/artworks/" + artwork.id
    jQuery("a.artwork").attr "title", artwork.title + " (" + (if artwork.year then artwork.year else "?") + ")"
    jImage.attr("src", artwork.big_image_url).fadeIn 1000

  @index = newIndex

window.BBase.Slideshow = Slideshow
