module ArticleExtendHelper
  def checked?(article, category)
    if article.category_ids.include?(category.id)
      check_box_tag 'categories[]', category.id, true
    else
      check_box_tag 'categories[]', category.id
    end
  end

  def link_edit_article(current_user, article)
    return unless current_user == article.author

    link_to 'Edit the article',
            edit_article_path(article.id),
            class: 'text-color-orange border d-block w-50 p-3 mt-3 mx-auto text-center text-decoration-none'
  end

  def show_main(article)
    return unless article.author == @current_user

    if article.main.attached?
      link_to('Delete Picture', article_main_delete_path(article_id: article.id), method: :delete)
    else
      form_with(url: article_main_update_path(article_id: article.id),
                method: :patch,
                class: 'd-flex flex-column justify-content-center') do |f|
        f.label(:main, 'Add the main picture') +
          f.file_field(:main) +
          f.submit('Upload', class: 'w-50')
      end
    end
  end

  def attach_photos(article)
    return unless @current_user == article.author

    form_with(url: article_photos_update_path(article_id: article.id),
              method: :patch,
              class: 'd-flex flex-column py-3') do |f|
      f.label(:photos, 'Add photos', class: 'py-1') +
        f.file_field(:photos, multiple: true, direct_upload: true, class: 'py-1') +
        f.submit('Upload', class: 'w-50')
    end
  end
end
