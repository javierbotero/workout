class ApplicationController < ActionController::Base

  private

  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  def logged_in?
    redirect_to form_loggin_path unless current_user
  end
end

