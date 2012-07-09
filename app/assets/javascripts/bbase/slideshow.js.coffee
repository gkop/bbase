Slideshow = {}
Slideshow.init = (artworks) ->
  @artworks = $.parseJSON($.unescape(artworks))
  @index = 0
  self = this
  $("#next a").click (e) ->
    self.timer.stop()
    self.next()
    e.preventDefault()

  $("#previous a").click (e) ->
    self.timer.stop()
    self.previous()
    e.preventDefault()

  $("#fullscreen a").click (e) =>
    @show(@index, true)
    false

  @timer = $.timer(->
    self.next()
  )

  @timer.set
    time: 10000
    autostart: true

  $(document).unbind("keydown")
  $(document).bind("keydown", this.keyFunc)

Slideshow.previous = ->
  @show (@index - 1) % @artworks.length

Slideshow.next = ->
  @show (@index + 1) % @artworks.length

Slideshow.show = (newIndex, startFullscreen = false) ->
  newIndex = @artworks.length - 1  if newIndex < 0
  artwork = @artworks[newIndex]
  if $("#fullscreenSlideshowContainer").is(":visible") or startFullscreen
    slide = @fullscreenContainer.data("slideshows").gallery[newIndex]
    @fullscreenContainer.trigger("show", ["gallery", slide])
    $(document).unbind("keydown")
    $(document).bind("keydown", this.keyFunc)
  jImage = $("#slideshow img")
  jImage.fadeOut 1000, ->
    $("a.artwork").attr "href", "/artworks/" + artwork.id
    $("a.artwork").attr "title", artwork.title + " (" + (if artwork.year then artwork.year else "?") + ")"
    jImage.attr("src", artwork.image.slideshow.url).fadeIn 1000

  @index = newIndex

Slideshow.keyFunc = (event) ->
  if event.keyCode is 27
    BBase.Slideshow.fullscreenContainer.trigger "close"
  $("#next a").trigger("click") if event.keyCode is 37
  $("#previous a").trigger("click") if event.keyCode is 39

$ ->
  $("div#preloaded-slideshow-images img").fullscreenslides()
  $container = $("#fullscreenSlideshowContainer")
  $container.bind("init", ->
    $container.append("<div class=\"ui\" id=\"fs-close\">&times;</div>").append("<div class=\"ui\" id=\"fs-loader\">Loading...</div>").append("<div class=\"ui\" id=\"fs-prev\">&lt;</div>").append("<div class=\"ui\" id=\"fs-next\">&gt;</div>").append "<div class=\"ui\" id=\"fs-caption\"><span></span></div>"
    $("#fs-prev").click ->
      $("#previous a").trigger("click")

    $("#fs-next").click ->
      $("#next a").trigger("click")

    $("#fs-close").click ->
      $container.trigger "close"
  ).bind("startLoading", ->
    $("#fs-loader").show()
  ).bind("stopLoading", ->
    $("#fs-loader").hide()
  ).bind("startOfSlide", (event, slide) ->
    $("#fs-caption span").text slide.title
    $("#fs-caption").show()
  ).bind "endOfSlide", (event, slide) ->
    $("#fs-caption").hide()

  Slideshow.fullscreenContainer = $container

window.BBase.Slideshow = Slideshow
