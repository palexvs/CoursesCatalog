jQuery ->
  $.datepicker.setDefaults
    dateFormat: "yy-mm-dd",
    firstDay: 1

@HandleCommonErr= (errors) ->
  try 
    msgs = $.parseJSON(errors.responseText)
  catch err
    msgs = errors.responseText
    newAlert(msgs, 'error')
    return
    
  if msgs.isArray
    newAlert(msg, 'error') for msg in msgs
  else
    newAlert(msgs.error, 'error')
    

@newAlert= (message, type = 'success') ->
  $("#alert-area").html($("<div class='alert-message alert alert-" + type + " fade in' data-alert><p> " + message + " </p></div>"))
  $(".alert-message").delay(2000).fadeOut("slow", -> $(this).remove() )