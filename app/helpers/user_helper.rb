module UserHelper
  def display_avatar(user)
    if user.avatar.attached?
      cloudinary_url(user.avatar.key)
    else
      asset_path('avatar.jpg')
    end
  end

  def friendship_invitation(author)
    return if author == @current_user

    if @current_user.friend_ids.include?(author.id)
      content_tag(:span, "Your are friend of #{author.username}") +
        link_to('Delete friendship', friendship_delete_path(friend_id: author.id), method: :delete)
    elsif (@current_user.pending_ids & author.request_ids).any?
      'Pending confirmation'
    elsif (@current_user.request_ids & author.pending_ids).any?
      link_to 'Confirm',
              friendship_confirm_path(friend_id: author.id,
                                      friendship_id: Friendship.find_by(user_id: author.id,
                                                                        friend_id: @current_user.id).id),
              method: :post
    else
      link_to "Add #{author.username}", friendships_path(friend_id: author.id), method: :post
    end
  end
end
