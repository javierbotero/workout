class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= session[:user_id] && User.includes(:friends, :votes, :pendings,
                                                         :requests, :friendships,
                                                         :avatar_attachment, :articles).find_by(id: session[:user_id])
  end

  def logged_in?
    redirect_to form_loggin_path unless current_user
  end

  def check_friendship
    owner_show_page = User.find(params[:id])
    return if owner_show_page == @current_user ||
              owner_show_page.friend_ids.include?(@current_user.id)

    flash[:alert] = "You aren't friend of this user :("
    redirect_to request.env['HTTP_REFERER']
  end
end
