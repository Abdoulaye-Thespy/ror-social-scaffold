class FriendshipsController < ApplicationController
  def new
    @friend = User.find_by_id(params[:user_id])
    @friendship = Friendship.find_by(user: current_user, friend: @friend)
    @inverse_friendship = Friendship.find_by(user: @friend, friend: current_user)

    if @friendship.nil? && @inverse_friendship.nil?
      friendship = current_user.friendships.new(friend_id: params[:user_id])
      friendship.confirmed = 0
      friendship.save
      redirect_to users_path, notice: 'Friend request sent.'
    end

    return unless !@friendship.nil? || !@inverse_friendship.nil?

    friendship = Friendship.find_or_create_by(user: current_user, friend: @friend)
    inverse_friendship = Friendship.find_or_create_by(user: @friend, friend: current_user)
    friendship.confirmed = 1
    inverse_friendship.confirmed = 1
    friendship.save
    inverse_friendship.save
    redirect_to users_path, notice: 'Friend request sent.'
  end

  def destroy
    friend = User.find_by_id(params[:user_id])
    inv = Friendship.find_by(user: friend, friend: current_user)
    not_inv = Friendship.find_by(user: current_user, friend: friend)
    if inv || not_inv
      inv&.destroy
      not_inv&.destroy
      redirect_to users_path, notice: 'Friend request delete.'
    else
      redirect_to users_path, notice: 'you cannot delete this friend request.'
    end
  end
end
