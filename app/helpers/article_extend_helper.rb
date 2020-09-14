module ArticleExtendHelper
  def checked?(article, category)
    if article.category_ids.include?(category.id)
      check_box_tag('categories[]', category.id, true, class: 'my-2')
    else
      check_box_tag('categories[]', category.id, false, class: 'my-2')
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

  def show_main_picture(article)
    cl_image_tag(article.main.key, class: 'w-100 d-block mx-auto rounded') if article.main.attached?
  end

  def display_pictures_with_delete(article)
    return unless article.photos.attached?

    content_tag(:div, class: 'd-flex flex-wrap w-100') do
      pictures = ''
      article.photos.each do |art|
        pictures << image_tag(art, class: 'images-article w-50 flex-grow-1 align-self-center py-2')
        pictures << display_delete_link(article, art)
      end
      pictures.html_safe
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

  def display_delete_link(article, picture)
    return unless article.author == @current_user

    link_to('delete',
            photos_destroy_path(article_id: article.id, pic_id: picture.id),
            method: :post, class: 'block w-50 text-center my-auto')
  end

  def display_pictures_article(pictures)
    return unless pictures.any?

    html = content_tag(:div, class: 'row w-100') do
      pics = ''
      pictures.each do |pic|
        pics << image_tag(pic, class: 'images-article col-sm-6 align-self-center p-2')
      end
      pics.html_safe
    end
    html.html_safe
  end

  def main_image_article(article)
    cl_image_tag article.main.key, class: 'w-50 h-50' if article.main.attached?
  end

  def display_options_article(article)
    html = ''
    Category.all.each do |catg|
      html << label_tag('categories', catg.name) +
              checked?(article, catg)
    end
    html.html_safe
  end
end
