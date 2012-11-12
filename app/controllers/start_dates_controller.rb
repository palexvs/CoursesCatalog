class StartDatesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :course, :find_by => :find_by_id
  load_and_authorize_resource :through => :course, :find_by => :find_by_id  

  def index
    # course = Course.find(params[:course_id])

    respond_to do |format|
      format.json { render json: @start_dates.to_json(:methods => ["pending?"]) }
    end        
  end

  def create
    # course = Course.find(params[:course_id])
    # start_date = course.start_dates.build(start_on: params[:start_on])
    @start_date.created_by = current_user.id

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
    # @start_date = StartDate.find(params[:id])

    respond_to do |format|
      if @start_date.destroy
        format.json { head :no_content }
      else
        format.json { render json: @start_date.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

end