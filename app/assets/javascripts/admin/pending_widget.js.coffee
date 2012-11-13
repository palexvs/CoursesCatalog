jQuery ->
  InitWidget()

InitWidget = () ->
  $('#widgets-panel').append($('<div id="pending-widget"></div>'))
  UpdatePendingList()


@UpdatePendingList = () ->
  $.ajax
    type: 'GET'
    url: '/courses/pending_list/'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      $('#pending-widget').html SMT['admin/courses/pending_widget']({  } )
      HandleCommonErr(jqXHR)
    success: (data, textStatus, jqXHR) ->
      $('#pending-widget').html SMT['admin/courses/pending_widget']({ courses: data } )