class FriendshipsController < ApplicationController
  before_action :logged_in?

  def create
    friendship = Friendship.new(user_id: @current_user.id, friend_id: params[:friend_id])
    return unless friendship.save

    flash[:notice] = 'Wait for friendship confirmation'
    redirect_to user_path(@current_user.id)
  end

  def confirm
    friendship = Friendship.find(params[:friendship_id])
    friendship.confirmed = true
    if Friendship.create(user_id: @current_user.id, friend_id: params[:friend_id], confirmed: true)
      flash[:notice] = 'You have confirmed this friendships'
      redirect_to user_path(@current_user)
    else
      flash[:alert] = 'Something wrong happened'
      redirect_to root_path
    end
  end

  def denied
    friendship = Friendship.find(params[:friendship_id])
    friendship.destroy
    flash[:notice] = 'You denied this request'
    redirect_to user_path(@current_user)
  end

  def delete_friendship
    record1 = Friendship.where(user_id: @current_user.id,
                               friend_id: params[:friend_id]).first
    record2 = Friendship.where(user_id: params[:friend_id],
                               friend_id: @current_user.id).first
    record1.destroy
    record2.destroy
    flash[:notice] = 'You have deleted this friendship'
    redirect_to root_path
  end
end
