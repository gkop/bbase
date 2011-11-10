BBase.Slideshow = {};

BBase.Slideshow.init = function(exhibitionData) {
  this.exhibition = jQuery.parseJSON(jQuery.unescape(exhibitionData));
  this.index = 0;

  self = this;
  jQuery('#next a').click( function(e) {
    self.next();
    e.preventDefault();
  });
  
  jQuery('#previous a').click( function(e) {
    self.previous();
    e.preventDefault();
  });
};

BBase.Slideshow.previous = function() {
  BBase.Slideshow.show((this.index-1) % this.exhibition.artworks.length);
};

BBase.Slideshow.next = function() {
  BBase.Slideshow.show((this.index+1) % this.exhibition.artworks.length);
};

BBase.Slideshow.show = function(newIndex) {
  if (newIndex < 0) {
    newIndex = this.exhibition.artworks.length - 1;
  }
  var artwork = this.exhibition.artworks[newIndex];
  jQuery('#slideshow img').attr('src', artwork.big_image_url);
  jQuery('a.artwork').attr('href', '/artworks/'+artwork.id);
  jQuery('#title a').html(artwork.title+" ("+(artwork.year ? artwork.year : "?")+")")
  this.index = newIndex;
};
