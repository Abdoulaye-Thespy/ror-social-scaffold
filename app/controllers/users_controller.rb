class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :set_friends

  def index
    @users = User.all.where('id != ?', current_user.id)
    @pend_friends = current_user.pending_friends
    @req_friends = current_user.friend_requests
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pend_friends = current_user.pending_friends
    @req_friends = current_user.friend_requests
    @friends = current_user.friends
  end
end
