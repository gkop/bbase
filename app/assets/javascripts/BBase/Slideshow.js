BBase.Slideshow = {};

BBase.Slideshow.init = function(galleryData, currentIndex) {
  this.gallery = jQuery.parseJSON(jQuery.unescape(galleryData));
  this.index = currentIndex;

  self = this;
  jQuery('#next a').click( function(e) {
    self.timer.stop();
    self.next();
    e.preventDefault();
  });
  
  jQuery('#previous a').click( function(e) {
    self.timer.stop();
    self.previous();
    e.preventDefault();
  });

  this.timer = jQuery.timer( function() {
    self.next();
  });
  this.timer.set({ time : 10000, autostart : true });
};

BBase.Slideshow.previous = function() {
  BBase.Slideshow.show((this.index-1) % this.gallery.artworks.length);
};

BBase.Slideshow.next = function() {
  BBase.Slideshow.show((this.index+1) % this.gallery.artworks.length);
};

BBase.Slideshow.show = function(newIndex) {
  if (newIndex < 0) {
    newIndex = this.gallery.artworks.length - 1;
  }
  var artwork = this.gallery.artworks[newIndex];
  var jImage = jQuery('#slideshow img');
  jImage.fadeOut(1000, function() {
    jQuery('a.artwork').attr('href', '/artworks/'+artwork.id);
    jQuery('a.artwork').attr('title', artwork.title+" ("+(artwork.year ? artwork.year : "?")+")")
    jImage.attr('src', artwork.big_image_url).fadeIn(1000);
  });
  this.index = newIndex;
};
