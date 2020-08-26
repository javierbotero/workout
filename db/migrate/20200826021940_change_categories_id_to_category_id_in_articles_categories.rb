class ChangeCategoriesIdToCategoryIdInArticlesCategories < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles_categories, :categories_id, :category_id
    add_foreign_key :articles_categories, :categories
  end
end
