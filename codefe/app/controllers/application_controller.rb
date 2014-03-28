class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session[:user_id]
      return User.find session[:user_id]
    else
      return nil
    end
  end

  def authenticate
    if current_user == nil
      flash[:notice] = "New User?"
      redirect_to login_path
    end
  end

end
