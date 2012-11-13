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
    @track_it.save
    respond_with(@course, @track_it)
  end

  def destroy
    @track_it.destroy
    respond_with(@course, @track_it)
  end

end