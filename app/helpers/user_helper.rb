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
      content_tag(:span, "Your are friend of #{author.username}", class: 'pr-3') +
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

  def user_avatar(user)
    if user.avatar.attached?
      content_tag(:p, 'Do you want to change your pic? you need to delete it first') +
        link_to('Delete picture', user_avatar_destroy_path(user_id: user.id), method: :post)
    else
      form_with(model: user,
                url: user_avatar_update_path(user_id: user.id),
                method: :patch,
                class: 'd-flex flex-column justify-content-center') do |f|
        f.label(:avatar, 'New picture', class: 'text-center my-1') +
          f.file_field(:avatar, direct_upload: true, class: 'text-center w-50 mx-auto my-1') +
          f.submit('Change Picture', class: 'w-50 mx-auto my-1')
      end
    end
  end

  def display_avatar_in_form(user)
    cl_image_tag(user.avatar, class: 'w-100') if user.avatar.attached?
  end

  def check_user_articles(user)
    return unless user.articles.any?

    render 'articles', user: @user
  end
end
