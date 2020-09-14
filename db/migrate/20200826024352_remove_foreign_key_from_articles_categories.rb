class RemoveForeignKeyFromArticlesCategories < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :articles_categories, :categories
  end
end
