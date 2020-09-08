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
    redirect_to edit_article_path(params[:article_id])
  end
end
