module ArticleHelper
  def sort_by_date(collection)
    collection.sort_by(&:created_at).reverse
  end
end
