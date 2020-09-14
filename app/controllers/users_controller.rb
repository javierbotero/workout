class UsersController < ApplicationController
  before_action :logged_in?, except: %i[new create]
  before_action :avoid_duplicates_user, only: %i[new create]
  before_action :check_friendship, only: :show

  def index
    @users = User.all.includes(:friends, :requests, :pendings)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Your account was created'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = 'Your username is too short or should be unique'
      render 'new'
    end
  end

  def show
    @user = User.includes(:articles).find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(username: params[:username])
      flash[:notice] = 'You updated your username succesfully'
      redirect_to user_path(@user)
    else
      flash[:alert] = 'Oops this username is invalid or repated'
      render 'edit'
    end
  end

  def destroy
    @current_user.destroy
    session[:user_id] = nil
    flash[:alert] = "#{@user.username} was deleted"
    @user.destroy
    redirect_to loggin_path
  end

  private

  def avoid_duplicates_user
    return unless current_user

    flash[:alert] = "You don't need more than one account"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:username, :avatar)
  end
end
