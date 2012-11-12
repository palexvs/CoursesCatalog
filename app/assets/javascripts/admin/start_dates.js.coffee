templates.start_dates_list = 'admin/courses/start_dates_list'

jQuery ->
  $('#start-dates-list-widget')
    .on('ajax:error', 'a.remove-date', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.remove-date', (xhr, data) -> UpdateStartDatesList() )
    .on('ajax:error', 'a.approve-date', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.approve-date', (xhr, data) -> UpdateStartDatesList() )