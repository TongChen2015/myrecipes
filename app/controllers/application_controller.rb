class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # to make them avaialble to the views
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]   
  end
  
  def logged_in?
    !!current_user  
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must logged in to perform this action"
      redirect_back fallback_location: root_path
    end
  end
end
