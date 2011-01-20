BBase.Forms = {};

BBase.Forms.registerHandlers = function() {
  $('select#artwork_location_created_city_state').live('change focus', function() {
    $('div#location_created div.site_form_container').load('/cities/painted?state='+$('select#artwork_location_painted_city_state').val());
  });
};
