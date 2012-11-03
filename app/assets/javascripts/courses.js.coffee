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

LoadWidgets = () ->
  UpdateMyCourses()

UpdateMyCourses = () ->
  $.ajax
    type: 'GET'
    url: '/courses/my_courses'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      HandleCommonErr(textStatus)
    success: (data, textStatus, jqXHR) ->
      MarkMyCoursesInList(data)
      $('#my_courses-widget').html MyCoursesWidgetTemplate(data)

MyCoursesWidgetTemplate = (courses) ->
  html = SMT['courses/my_courses']({ courses: courses } );

MarkMyCoursesInList = (courses) ->
  $("#courses-list tr.tracked").removeClass("tracked")
  for course in courses
    $("#courses-list tr#course_#{course.id}").addClass("tracked")