class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message  
    respond_to do |format|  
      format.json { render :json => "You don't have access to do it" , :status => :forbidden }  
      format.html { redirect_to root_url }  
    end     
  end  
end
