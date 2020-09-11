class ArticlesController < ApplicationController
  before_action :logged_in?

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params_article)
    if @article.save
      @article.category_ids = params[:categories]
      @article.photos.attach(params[:article][:photos])
      flash[:notice] = "You have created the article #{@article.title}"
      redirect_to article_path(@article)
    else
      flash.now[:alert] = "Looks like you didn't fill required fields"
      render 'new'
    end
  end

  def show
    @article = Article.includes(:author, :main_attachment, :photos_attachments).find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params_article)
      @article.category_ids = params[:categories]
      @article.photos.attach(params[:article][:photos]) if params[:article][:photos]
      flash[:notice] = 'Article succesfully saved'
      redirect_to article_path(@article)
    else
      flash.now[:alert] = 'Some fields were not filled well'
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = 'The article was deleted'
    redirect_to categories_path
  end

  private

  def params_article
    params.require(:article)
      .permit(:title, :text, :author_id, :main)
      .with_defaults(author_id: @current_user.id)
  end
end
