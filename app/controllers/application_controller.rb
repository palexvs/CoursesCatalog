class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|  
      format.json { render :json => exception.message , :status => :forbidden }  
      format.html { redirect_to root_url, :alert => exception.message }  
    end     
  end  

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|  
      format.json { render :json => exception.message , :status => :forbidden }  
      format.html { redirect_to root_url, :alert => exception.message }  
    end     
  end  
end
