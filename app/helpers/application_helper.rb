module ApplicationHelper
  def vote_decision(user_id, article)
    if article.voter_ids.include?(user_id)
      vote = Vote.where(user_id: user_id, article_id: article.id).first
      link_to(vote_path(vote.id), method: :delete) do
        fa_icon 's heart', class: 'text-danger'
      end
    else
      link_to(votes_path(article_id: article.id, user_id: user_id), method: :post) do
        fa_icon 's heart', class: 'text-secondary'
      end
    end
  end

  def display_links(current_user)
    if current_user
      content_tag :div, class: 'greeting' do
        link_to("Hello #{@current_user.username}",
                user_path(@current_user),
                class: 'text-decoration-none text-color-orange text-uppercase font-navbar') << ' | ' <<
          link_to('Log out', logout_path, class: 'text-decoration-none color-app text-uppercase font-navbar')
      end
    else
      content_tag :div, class: 'greeting' do
        link_to('Log in',
                form_loggin_path,
                class: 'text-decoration-none color-app text-uppercase font-navbar') << ' | ' <<
          link_to('Register', new_user_path, class: 'text-decoration-none color-app text-uppercase font-navbar')
      end
    end
  end

  def display_navbar(category)
    return if category

    render 'layouts/navbar'
  end

  def display_footer(category)
    return unless category

    render 'layouts/footer'
  end

  def display_middle_links(current_user)
    return unless current_user

    link_to('Write an Article',
            new_article_path,
            class: 'text-decoration-none color-app text-uppercase font-navbar pr-3') << '  ' <<
      link_to('Your Place',
              user_path(@current_user.id),
              class: 'text-decoration-none color-app text-uppercase font-navbar')
  end

  def show_errors_form(article)
    html = ''
    if article.errors.any?
      html << content_tag(:div, class: 'p-3 bg-color-orange rounded') do
        content_tag(:h5) do
          pluralize(article.errors.count, 'error') + ' prohibited from being saved.'
        end <<
          content_tag(:ul) do
            errors = ''
            article.errors.full_messages.each do |msg|
              errors << content_tag(:li, msg)
            end
            errors.html_safe
          end
      end
    end
    html.html_safe
  end

  def display_flahs(flash)
    html = ''
    if flash.any?
      flash.each do |name, msg|
        html << content_tag(:div,
                            msg,
                            class: "w-75 mx-auto
 rounded d-flex justify-content-center align-items-center m-2 #{name}")
      end
    end
    html.html_safe
  end
end
