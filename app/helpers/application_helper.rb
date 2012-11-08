module ApplicationHelper

  STATUSES = {'draft' => 'Default', 'publish' => 'Success', 'pending' => 'Important'}

  def show_publish_status(object)
    return  if object.nil?

    html = "<span class='publish-status label #{STATUSES[object.publish_status]}'>#{object.publish_status}</span>"
    html
  end
end
