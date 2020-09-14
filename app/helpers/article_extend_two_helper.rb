module ArticleExtendTwoHelper
  def more_voted_link
    more_voted_article.nil? ? root_path : article_path(more_voted_article.id)
  end

  def title_more_voted
    more_voted_article ? more_voted_article.title : 'No more voted article'
  end

  def text_more_voted
    more_voted_article ? more_voted_article.text : 'No more voted article'
  end
end
