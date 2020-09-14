class CategoriesController < ApplicationController
  before_action :logged_in?

  def index
    @categories = Category.all.includes(articles: :main_attachment)
  end

  def show
    @category = Category.includes(:articles).find(params[:id])
    @articles = @category.articles.includes(:main_attachment, :author, :voters)
  end
end
