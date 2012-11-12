class TrackItsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :course, :find_by => :find_by_id
  load_and_authorize_resource :track_it, :through => [:course, :current_user], :find_by => :find_by_id

  respond_to :json

  def index
    @track_its = @track_its.with_course

    render json: @track_its.to_json(include: :course)
  end  

  def create
    if @track_it.course_id.nil? 
      render :json => "Can't start track it", status: :unprocessable_entity
      return
    end

    if @track_it.save
      head :no_content
    else
      render :json => @track_it.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @track_it.nil? 
      render :json => "Can't untrack it", status: :unprocessable_entity
      return
    end

    if @track_it.destroy
      head :no_content
    else
      render json: @track_it.errors, status: :unprocessable_entity
    end
  end

end