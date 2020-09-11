module CategoryHelper
  def check_category_articles(articles)
    if @category.articles.any?
      render 'articles', articles: articles
    else
      content_tag(:p,
                  'No articles written lately, you can write one if you feel inspirated :)',
                  class: 'h-100 background-app text-light')
    end
  end
end
