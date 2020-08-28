module ApplicationHelper
  def vote_decision(user_id, article)
    if article.voter_ids.include?(user_id)
      vote = Vote.where(user_id: user_id, article_id: article.id).first
      button_to('Delete Vote', vote_path(vote.id), method: :delete)
    else
      button_to('Vote', votes_path, method: :post, params: { article_id: hiking.id, user_id: javier.id })
    end
  end
end
