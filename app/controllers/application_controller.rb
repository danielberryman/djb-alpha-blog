class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
  	# if there is a user_id in the current session then find the corresponding user based on that user id
  	# this creates the entire user object
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	#if this current user already exists we don't want multiple user hits on a page
  	#this is called mamelization
  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:danger] = "You must be logged in to perform this action"
  		redirect_to root_path
  	end
  end

end
