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
      content_tag :span, "Your are friend of #{author.username}"
    else
      link_to "Be friend of #{@article.author.username}", friendships_path(friend_id: author.id)
    end
  end
end
