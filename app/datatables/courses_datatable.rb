class CoursesDatatable
  delegate :params, :dom_id, :h, :link_to, :course_track_its_path, to: :@view

  def initialize(view, courses, track_course_ids)
    @view = view
    @courses_source = courses
    @track_course_ids = track_course_ids
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @courses_source.count,
      iTotalDisplayRecords: courses.total_entries,
      aaData: data
    }
  end

private

  def data
    courses.map do |course|
      {
        "0" => link_to(course.name, course),
        "1" => h(course.date),
        "2" => link_to("Trak it", course_track_its_path(course), class: 'btn btn-mini track-it', format: :json, remote: true, method: :post),
        # "DT_RowId" => dom_id(course),
        "DT_RowClass" => (@track_course_ids.include?(course.id) ? "tracked" : "") + " " + dom_id(course) 
      }
    end
  end

  def courses
    @courses ||= fetch_courses
  end

  def fetch_courses
    courses = @courses_source.order("#{sort_column} #{sort_direction}")
    courses = courses.page(page).per_page(per_page)
    if params[:sSearch].present?
      courses = courses.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    courses
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[date name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end