@templates = {}

jQuery ->
  $.datepicker.setDefaults
    dateFormat: "yy-mm-dd",
    firstDay: 1
    
  $(".alert-success").delay(2000).fadeOut("slow", -> $(this).remove() )

@HandleCommonErr= (errors) ->
  try 
    msgs = $.parseJSON(errors.responseText)
  catch err
    msgs = errors.responseText
    newAlert(msgs, 'error')
    return
    
  if $.isArray(msgs)
    newAlert(msg, 'error') for msg in msgs
  else
    newAlert(msgs.error, 'error')
    

@newAlert= (message, type = 'success') ->
  $("#alert-area").append(
    $("<div class='alert-message alert alert-" + type + " fade in' data-alert><p> " + message + " </p></div>")
      .delay(2000).fadeOut("slow", -> $(this).remove() )
  )