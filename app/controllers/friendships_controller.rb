class FriendshipsController < ApplicationController
  before_action :logged_in?

  def create
    friendship = Friendship.find_by(user_id: @current_user.id, friend_id: params[:friend_id])
    if friendship
      flash[:alert] = friendship.confirmed ? 'You are friend already' : 'This friendship is pending'
    else
      Friendship.create(user_id: @current_user.id, friend_id: params[:friend_id], confirmed: false)
      flash[:notice] = 'Wait for friendship confirmation'
    end
    redirect_to request.env['HTTP_REFERER']
  end

  def confirm
    friendship = Friendship.find(params[:friendship_id])
    friendship.update(confirmed: true)
    if Friendship.create(user_id: @current_user.id, friend_id: params[:friend_id], confirmed: true)
      flash[:notice] = 'You have confirmed this friendships'
    else
      flash[:alert] = 'Something wrong happened'
    end
    redirect_to request.env['HTTP_REFERER']
  end

  def denied
    friendship = Friendship.find(params[:friendship_id])
    friendship.destroy
    flash[:notice] = 'You denied this request'
    redirect_to request.env['HTTP_REFERER']
  end

  def delete_friendship
    record1 = Friendship.where(user_id: @current_user.id,
                               friend_id: params[:friend_id]).first
    record2 = Friendship.where(user_id: params[:friend_id],
                               friend_id: @current_user.id).first
    record1.destroy
    record2.destroy
    flash[:notice] = 'You have deleted this friendship'
    redirect_to request.env['HTTP_REFERER']
  end
end
