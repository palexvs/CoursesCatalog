# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  LoadWidgets()

  $('#courses-list, .course-show')
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
    url: '/track_its/'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      $('#my_courses-widget').html SMT['courses/my_courses']({  } )
      HandleCommonErr(jqXHR)
    success: (data, textStatus, jqXHR) ->
      MarkMyCoursesInList(data)
      $('#my_courses-widget').html SMT['courses/my_courses']({ track_its: data } )

MarkMyCoursesInList = (track_its) ->
  $(".tracked").removeClass("tracked")
  for track_it in track_its
    $(".course_#{track_it.course_id}").addClass("tracked")