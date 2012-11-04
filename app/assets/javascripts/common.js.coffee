jQuery ->
  $.datepicker.setDefaults
    dateFormat: "yy-mm-dd",
    firstDay: 1
      
  $('input.datepicker[type="text"]').datepicker()

@HandleCommonErr= (errors) ->
  newAlert(msg, 'error') for msg in $.parseJSON(errors.responseText)

@newAlert= (message, type = 'success') ->
  $("#alert-area").html($("<div class='alert-message alert alert-" + type + " fade in' data-alert><p> " + message + " </p></div>"))
  $(".alert-message").delay(2000).fadeOut("slow", -> $(this).remove() )