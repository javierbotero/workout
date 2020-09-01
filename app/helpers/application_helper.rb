module ApplicationHelper
  def vote_decision(user_id, article)
    if article.voter_ids.include?(user_id)
      vote = Vote.where(user_id: user_id, article_id: article.id).first
      button_to('Delete Vote', vote_path(vote.id), method: :delete)
    else
      button_to('Vote', votes_path, method: :post, params: { article_id: hiking.id, user_id: javier.id })
    end
  end

  def custom_navbar(confirmation)
    confirmation ? 'no-nav' : 'yes-nav'
  end

  def display_links(current_user)
    if current_user
      content_tag :div, class: 'greeting' do
        link_to('Write an Article', new_article_path) << ' | ' <<
          link_to('Log out', logout_path) << ' | ' \
          "Hello #{@current_user.username}"
      end
    else
      content_tag :div, class: 'greeting' do
        link_to('Log in', form_loggin_path) << ' | ' <<
          link_to('Register', new_user_path)
      end
    end
  end
end
