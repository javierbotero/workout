module CategoryHelper
  def check_category_articles(articles, category)
    if category.articles.any?
      display_articles(articles, category)
    else
      content_tag(:p,
                  'No articles written lately, you can write one if you feel inspirated :)',
                  class: 'h-100 background-app text-light')
    end
  end

  def display_articles(articles, category = nil)
    i = 0
    switcher = true
    html = ''
    sort_by_date(articles).each do |article|
      html << if switcher
                render('categories/articles',
                       { article: article,
                         category: category.nil? ? article.categories.first : category })
              else
                render('categories/articles_switched',
                       { article: article,
                         category: category.nil? ? articles.categories.first : category })
              end
      i += 1
      if i > 1
        i = 0
        switcher = switcher ? false : true
      end
    end
    html.html_safe
  end

  def category_nil(category)
    category.nil? ? 'Uncategorized' : category.name
  end

  def display_articles_show_page(categories)
    html = ''
    if categories.any?
      categories.each do |category|
        html << link_to(article_id(category.articles, category),
                        style: "background-image: linear-gradient(to bottom, rgba(0, 0, 0, .7), 20%,
 transparent, 80%, rgba(0, 0, 0, .7)), url(#{main_picture(category.articles)})",
                        class: 'col-sm-3 d-flex flex-column align-items-start border border-secondary
 add-background text-decoration-none text-white p-3') do
          content_tag(:h5, category.name, class: 'mb-auto') +
            content_tag(:h5, article_title(category.articles), class: '')
        end
      end
    else
      articles = Article.includes(:main_attachment).last(4)
      4.times do |i|
        html << if articles[3 - i].nil?
                  link_to('Write an Article',
                          new_article_path,
                          style: "background-image: linear-gradient(to bottom, rgba(0, 0, 0, .7), 20%,
                          transparent, 80%, rgba(0, 0, 0, .7)), url(#{asset_path('avatar.jpg')})",
                          class: 'col-sm-3 d-flex flex-column align-items-start
border border-secondary add-background text-decoration-none text-white p-3')
                else
                  link_to(article_path(articles[3 - i].id),
                          style: "background-image: linear-gradient(to bottom, rgba(0, 0, 0, .7), 20%,
transparent, 80%, rgba(0, 0, 0, .7)), url(#{main_picture(articles)})",
                          class: 'col-sm-3 d-flex flex-column align-items-start border border-secondary
add-background text-decoration-none text-white p-3') do
                    content_tag(:h5, 'Without category', class: 'mb-auto') +
                      content_tag(:h5, article_title(articles), class: '')
                  end
                end
      end
    end
    html.html_safe
  end

  def create_categories
    return if Category.any?

    Category.create(name: 'Indoors', priority: 1)
    Category.create(name: 'Outdoors', priority: 2)
    Category.create(name: 'Singly', priority: 3)
    Category.create(name: 'Group', priority: 4)
  end
end
