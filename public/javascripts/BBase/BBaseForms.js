BBase.Forms = {
  timer: 0
};

BBase.Forms.registerHandlers = function() {
  var self = this;

  // live load cities by state
  $('select#artwork_location_created_city_state').live('mouseup keypress', function() {
    self.delay(function() {  
      $('div#location_created_form div.site_form_container').load('/cities/created?state='+$('select#artwork_location_created_city_state').val());
    }, 250);
  });

  $('div#location_created_form a#new-city').live('click', function(e) {
    $('div#location_created_form div.new_city_form_container').load('/cities/new?state='+$('select#artwork_location_created_city_state').val());
    e.preventDefault();
  });

};

// General delay function, used to watch input events,
// Taken from: http://stackoverflow.com/questions/1909441/jquery-keyup blur-delay
BBase.Forms.delay = function(callback, ms){
  clearTimeout (this.timer);
  this.timer = setTimeout(callback, ms);
};


