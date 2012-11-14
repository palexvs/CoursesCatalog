class CoursesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  respond_to :html, :json
  
  def index
    @courses = @courses.with_closest_start_date.publish_only
    @track_course_ids =  user_signed_in? ? current_user.track_its.pluck(:course_id).uniq : []

    respond_to do |format|
      format.html
      format.json { render json: CoursesDatatable.new(view_context, @courses, @track_course_ids) }
    end
  end

  def pending_list
    @courses = @courses.where("publish_status = ? OR id IN (?)", "pending", StartDate.pending_only.pluck(:course_id).uniq )
    respond_with(@courses)
  end

  def show
    respond_with(@course)
  end

  def new
    respond_with(@course)
  end

  def edit
    respond_with(@course)
  end

  def create
    flash[:notice] = 'Course was successfully created.' if @course.save
    respond_with(@course)
  end

  def update
    authorize! :publish, @course if params[:course] && params[:course][:publish_status] == "publish"

    flash[:notice] = 'Course was successfully updated.' if @course.update_attributes(params[:course])
    respond_with(@course)
  end

  def destroy
    @course.destroy
    flash[:notice] = 'Course was successfully deleted.'
    respond_with(@course)
  end

end