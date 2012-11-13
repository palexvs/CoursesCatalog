module ApplicationHelper

  STATUSES = {'draft' => 'default', 'publish' => 'success', 'pending' => 'important'}

  def show_publish_status(object)
    return  if object.nil?

    "<span class='publish-status label label-#{STATUSES[object.publish_status]}'>#{object.publish_status}</span>".html_safe
  end
end
