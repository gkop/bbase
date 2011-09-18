BBase.NoteEditor = {}

BBase.NoteEditor.init = function(modelName) {
  this.modelName = modelName;
  var selector = "input[id*='"+modelName+"']"
  jQuery(selector).attr("value", jQuery("textarea#input-box").val());
  var width = jQuery(window).width() * 0.9;
  var height = jQuery(window).height();
  jQuery("#editor textarea#input-box").css("height", height*0.7);
  jQuery("#editor textarea#input-box").css("width", width*0.49);
  jQuery("#editor #preview").css("height", height*0.7-20);
  jQuery("#editor").css("height", height*0.8);
  jQuery("#editor #preview").css("width",  width*0.49-50);
  jQuery("a#edit-link").bind('click', function(e) {
    BBase.NoteEditor.startEditing();
    e.preventDefault();
  });
  jQuery("#actions input[value='Cancel']").live('click', function() {
    BBase.NoteEditor.cancelEditing();
  });
  jQuery("#actions input[value='Continue']").live('click', function() {
    BBase.NoteEditor.finishEditing();
  });
  this.converter = new Attacklab.showdown.converter();
}

BBase.NoteEditor.startEditing = function() {
  var width = jQuery(window).width() * 0.9;
  jQuery.liteDialog({
    html: jQuery("#editor-wrapper").html(),
    width: width+'px',
    modal: true
  });
  BBase.NoteEditor.livePreview();
  jQuery("textarea#input-box").bind('keyup', function() {
    BBase.NoteEditor.livePreview();
  });
  jQuery("body, html").css("overflow", "hidden");
}

BBase.NoteEditor.cancelEditing = function() {
  jQuery("body, html").css("overflow", "auto");
  jQuery.liteDialog('hide');
}


BBase.NoteEditor.finishEditing = function() {
  var selector = "input[id*='"+this.modelName+"']"
  jQuery(selector).attr("value", jQuery("#hyLiteDialog textarea#input-box").val());
  jQuery("textarea#input-box").html(jQuery("input[id*='"+this.modelName+"'").attr("value"));
  jQuery("#display-note").html(this.converter.makeHtml(jQuery("#hyLiteDialog textarea#input-box").val()));
  this.cancelEditing();
}

BBase.NoteEditor.livePreview = function() {
  jQuery("#hyLiteDialog #preview").html(this.converter.makeHtml(jQuery("#hyLiteDialog textarea#input-box").val()));
}
