class FriendshipsController < ApplicationController
  def new
    friend = User.find_by_id(params[:user_id])
    friendship = Friendship.find_by(user: current_user, friend: friend)
    inv = Friendship.find_by(user: friend, friend: current_user)

    if friendship.nil? && inv.nil?
      @friendship = current_user.friendships.new(friend_id: params[:user_id])
      @friendship.confirmed = 0
      @friendship.save
      redirect_to users_path, notice: 'Friend request sent.'
     end

    if !inv.nil? || !friendship.nil? && friendship.confirmed == false
      inv = Friendship.find_or_create_by(user: friend, friend: current_user)
      not_inv = Friendship.find_or_create_by(user: current_user, friend: friend)
      not_inv.confirmed = 1
      not_inv.save
      inv.confirmed = 1
      inv.save
      redirect_to users_path, notice: 'Friend request sent.'
      end
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
