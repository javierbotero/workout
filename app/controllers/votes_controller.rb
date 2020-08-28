class VotesController < ApplicationController
  before_action :logged_in?

  def create
    vote = Vote.new(user_id: params[:user_id], article_id: params[:article_id])
    if vote.save
      flash[:notice] = 'You voted succesfully'
      redirect_to article_path(params[:article_id])
    else
      flash[:alert] = 'Something went wrong notify us through our mail service'
      redirect_to root_path
    end
  end

  def destroy
    vote = Vote.find(params[:id])
    vote.destroy
    flash[:notice] = 'Your vote was deleted'
    redirect_to root_path
  end
end
