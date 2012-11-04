class StartDatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    course = Course.find(params[:course_id])

    respond_to do |format|
      format.json { render json: course.start_dates }
    end        
  end

  def create
    course = Course.find(params[:course_id])
    start_date = course.start_dates.build(start_on: params[:start_on])

    respond_to do |format|
      if start_date.save
        format.json { head :no_content }
      else
        format.json { render :json => start_date.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    start_date = StartDate.find(params[:id])

    respond_to do |format|
      if start_date.destroy
        format.json { head :no_content }
      else
        format.json { render json: start_date.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

end