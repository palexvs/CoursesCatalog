class TrackItsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :course
  load_and_authorize_resource :track_it, :through => [:course, :current_user]

  respond_to :json

  def index
    @track_its = @track_its.with_course

    render json: @track_its.to_json(include: :course)
  end  

  def create
    if @track_it.save
      head :no_content
    else
      render :json => @track_it.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @track_it.destroy
      head :no_content
    else
      render json: @track_it.errors, status: :unprocessable_entity
    end
  end

end