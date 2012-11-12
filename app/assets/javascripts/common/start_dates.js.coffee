templates.start_dates_list = 'courses/start_dates_list'

jQuery ->
  $('#start-dates-list-widget')
    .on('click', 'a.add-date', () -> ShowDatepicker())

ShowDatepicker = () ->
  $('#start-dates-list-widget #datepicker').datepicker
    showButtonPanel: true
    onSelect: (dateText, inst) -> CreateDate(dateText) 
  $('#start-dates-list-widget #datepicker').datepicker('show')

CreateDate = (dateText) ->
  course_id = $('#start-dates-list-widget').data('course-id')
  $.ajax
    type: 'POST'
    url: "/courses/#{course_id}/start_dates"
    data: 
      start_date:
        start_on: dateText
        publish_status: "pending"
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      HandleCommonErr(jqXHR)
    success: (data, textStatus, jqXHR) ->
      UpdateStartDatesList()

@UpdateStartDatesList = () ->
  course_id = $('#start-dates-list-widget').data('course-id')
  $.ajax
    type: 'GET'
    url: "/courses/#{course_id}/start_dates"
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      HandleCommonErr(jqXHR)
    success: (data, textStatus, jqXHR) ->
      $('#start-dates-list-widget fieldset').html SMT[templates.start_dates_list]({ course_id: course_id, start_dates: data } )    