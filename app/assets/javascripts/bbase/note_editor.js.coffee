NoteEditor = {}
NoteEditor.init = (modelName) ->
  @modelName = modelName
  selector = "input[id*='" + modelName + "']"
  jQuery(selector).attr "value", jQuery("textarea#input-box").val()
  width = jQuery(window).width() * 0.9
  height = jQuery(window).height()
  jQuery("#editor textarea#input-box").css "height", height * 0.7
  jQuery("#editor textarea#input-box").css "width", width * 0.49
  jQuery("#editor #preview").css "height", height * 0.7 - 20
  jQuery("#editor").css "height", height * 0.8
  jQuery("#editor #preview").css "width", width * 0.49 - 50
  jQuery("a#edit-link").bind "click", (e) ->
    NoteEditor.startEditing()
    e.preventDefault()

  jQuery("#actions input[value='Cancel']").live "click", ->
    NoteEditor.cancelEditing()

  jQuery("#actions input[value='Continue']").live "click", ->
    NoteEditor.finishEditing()

  @converter = new Attacklab.showdown.converter()

NoteEditor.startEditing = ->
  width = jQuery(window).width() * 0.9
  jQuery.liteDialog
    html: jQuery("#editor-wrapper").html()
    width: width + "px"
    modal: true

  NoteEditor.livePreview()
  jQuery("textarea#input-box").bind "keyup", ->
    NoteEditor.livePreview()

  jQuery("body, html").css "overflow", "hidden"

NoteEditor.cancelEditing = ->
  jQuery("body, html").css "overflow", "auto"
  jQuery.liteDialog "hide"

NoteEditor.finishEditing = ->
  selector = "input[id*='" + @modelName + "']"
  jQuery(selector).attr "value", jQuery("#hyLiteDialog textarea#input-box").val()
  jQuery("textarea#input-box").html jQuery("input[id*='" + @modelName + "']").attr("value")
  jQuery("#display-note").html @converter.makeHtml(jQuery("#hyLiteDialog textarea#input-box").val())
  @cancelEditing()

NoteEditor.livePreview = ->
  jQuery("#hyLiteDialog #preview").html @converter.makeHtml(jQuery("#hyLiteDialog textarea#input-box").val())

window.BBase.NoteEditor = NoteEditor
