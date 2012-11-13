class StartDatesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :course
  load_and_authorize_resource :start_date, :through => [:course, :current_user]

  respond_to :json

  def index
    render json: @start_dates.to_json(:methods => ["pending?"])
  end

  def create
    @start_date.save
    respond_with(@course, @start_date)
  end

  def update
    authorize! :publish, @start_date if params[:start_date] && params[:start_date][:publish_status] == "publish"

    @start_date.update_attributes(params[:start_date])
    respond_with(@course, @start_date)
  end  

  def destroy
    @start_date.destroy
    respond_with(@course, @start_date)    
  end

end