class LogginsController < ApplicationController
  before_action :logged_in?, except: %i[loggin form_loggin]

  def form_loggin; end

  def loggin
    @user = User.find_by(username: params[:username])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = 'You logged in succesfully'
      redirect_to root_path, format: :html
    else
      flash[:alert] = "You have to register if you don't have an account"
      redirect_to new_user_path
    end
  end

  def logout
    if session[:user_id]
      session[:user_id] = nil
      @current_user = nil
      flash[:notice] = 'You were logout'
      redirect_to root_path
    else
      flash.now[:alert] = 'You need to loggin first'
      render 'users/new'
    end
  end
end