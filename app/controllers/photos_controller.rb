class PhotosController < ApplicationController
  before_action :logged_in?

  def destroy
    article = Article.find(params[:article_id])
    if params[:pic_id]
      article.photos.find(params[:pic_id]).purge
    else
      article.main.purge
    end
    flash[:notice] = 'The picture has been deleted'
    redirect_to request.env['HTTP_REFERER']
  end

  def photos_update
    article = Article.find(params[:article_id])
    article.photos.attach(params[:photos])
    flash[:notice] = 'Photos uploaded'
    redirect_to request.env['HTTP_REFERER']
  end

  def avatar_destroy
    user = User.find(params[:user_id])
    if user.avatar.attached?
      user.avatar.purge
      flash[:notice] = 'User picture was deleted'
    else
      flash[:alert] = 'User picture does not exist'
    end
    redirect_to request.env['HTTP_REFERER']
  end

  def update_avatar
    user = User.find(params[:user_id])
    user.update(avatar: params[:user][:avatar])
    flash[:notice] = 'Your picture was changed'
    redirect_to request.env['HTTP_REFERER']
  end

  def destroy_main
    article = Article.find(params[:article_id])
    article.main.purge
    flash[:notice] = 'You deleted the main picture'
    redirect_to request.env['HTTP_REFERER']
  end

  def update_main
    article = Article.find(params[:article_id])
    if article.update(main: params[:main])
      flash[:notice] = 'You updated the main picture'
    else
      flash[:alert] = 'Main picture could not be updated'
    end
    redirect_to request.env['HTTP_REFERER']
  end
end
