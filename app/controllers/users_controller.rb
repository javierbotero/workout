class UsersController < ApplicationController
  before_action :logged_in?, except: %i[new create]
  before_action :avoid_duplicates_user, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(username: params[:username])
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
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    flash[:alert] = "#{@user.username} was deleted"
    @user.destroy
    redirect_to root_path
  end

  private

  def avoid_duplicates_user
    return unless current_user

    flash[:alert] = "You don't need more than one account"
    redirect_to root_path
  end
end
