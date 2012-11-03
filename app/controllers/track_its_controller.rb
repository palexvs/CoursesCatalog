class TrackItsController < ApplicationController
  before_filter :authenticate_user!

  def create
    course = Course.find(params[:course_id])
    association = current_user.track_its.build(course: course)

    respond_to do |format|
      if association.save
        format.json { head :no_content }
      else
        format.json { render :json => association.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    association = current_user.track_its.where(course_id: params[:course_id]).first

    respond_to do |format|
      if association.destroy
        format.json { head :no_content }
      else
        format.json { render json: association.errors, status: :unprocessable_entity }
      end
    end
  end

end