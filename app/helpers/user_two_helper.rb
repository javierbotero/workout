module UserTwoHelper
  def show_pendings
    html = ''
    if @current_user.pendings.any?
      @current_user.pendings.includes(:friend).each do |pending|
        html << content_tag(:div, class: 'p-2 text-center border rounded m-1') do
          link_to('',
                  user_path(pending.friend_id),
                  class: 'user-avatar',
                  style: "background-image: url(#{display_avatar(pending.friend)})") +
            content_tag(:p, pending.friend.username, class: 'text-white')
        end
      end
    else
      html << content_tag(:p, 'No pendings')
    end
    html.html_safe
  end

  def display_friendships(current_user, user)
    return unless current_user == user

    render 'users/friendships'
  end
end
