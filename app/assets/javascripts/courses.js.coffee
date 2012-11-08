# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  LoadWidgets()

  $('#courses-list')
    .on('ajax:error', 'a.track-it', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.track-it', (xhr, data) -> UpdateMyCourses())

  $('#my_courses-widget')
    .on('ajax:error', 'a.untrack-it', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.untrack-it', (xhr, data) -> UpdateMyCourses())    

  $('#start-dates-list-widget')
    .on('ajax:error', 'a.remove-date', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.remove-date', (xhr, data) -> UpdateStartDatesList() )
    .on('click', 'a.add-date', () -> ShowDatepicker())

LoadWidgets = () ->
  UpdateMyCourses()

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
      start_on: dateText
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      HandleCommonErr(jqXHR)
    success: (data, textStatus, jqXHR) ->
      UpdateStartDatesList()

UpdateStartDatesList = () ->
  course_id = $('#start-dates-list-widget').data('course-id')
  $.ajax
    type: 'GET'
    url: "/courses/#{course_id}/start_dates"
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      HandleCommonErr(jqXHR)
    success: (data, textStatus, jqXHR) ->
      $('#start-dates-list-widget fieldset').html SMT['courses/start_dates_list']({ course_id: course_id, start_dates: data } )

UpdateMyCourses = () ->
  $.ajax
    type: 'GET'
    url: '/courses/my_courses'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      $('#my_courses-widget').html SMT['courses/my_courses']({  } )
      HandleCommonErr(jqXHR)
    success: (data, textStatus, jqXHR) ->
      MarkMyCoursesInList(data)
      $('#my_courses-widget').html SMT['courses/my_courses']({ courses: data } )

MarkMyCoursesInList = (courses) ->
  $("#courses-list tr.tracked").removeClass("tracked")
  for course in courses
    $("#courses-list tr#course_#{course.id}").addClass("tracked")