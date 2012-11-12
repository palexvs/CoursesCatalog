class StartDatesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :course
  load_and_authorize_resource :start_date, :through => [:course, :current_user]

  def index
    respond_to do |format|
      format.json { render json: @start_dates.to_json(:methods => ["pending?"]) }
    end        
  end

  def create
    # @start_date.created_by = current_user.id
    respond_to do |format|
      if @start_date.save
        format.json { head :no_content }
      else
        format.json { render :json => @start_date.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :publish, @start_date if params[:start_date] && params[:start_date][:publish_status] == "publish"

    if @start_date.update_attributes(params[:start_date])
      head :no_content
    else
      render json: @start_date.errors.full_messages, status: :unprocessable_entity
    end
  end  

  def destroy
    respond_to do |format|
      if @start_date.destroy
        format.json { head :no_content }
      else
        format.json { render json: @start_date.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

end