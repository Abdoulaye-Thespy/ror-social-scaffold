class FriendshipsController < ApplicationController

	def new
		friend=User.find_by_id(params[:user_id])
		@inversefriendship=friend.inverse_friendships.new(user_id: current_user.id)
		@friendship = current_user.friendships.new(friend_id: params[:user_id])
		@friendship.confirmed=0
		@friendship.save
		@inversefriendship.confirmed=0
		@inversefriendship.save
		redirect_to users_path, notice: 'You liked a post.'
	end
   def create

    

    if @like.save
      redirect_to posts_path, notice: 'You liked a post.'
    else
      redirect_to posts_path, alert: 'You cannot like this post.'
    end
  end

  def destroy
    like = Like.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
    if like
      like.destroy
      redirect_to posts_path, notice: 'You disliked a post.'
    else
      redirect_to posts_path, alert: 'You cannot dislike post that you did not like before.'
    end
  end
end
