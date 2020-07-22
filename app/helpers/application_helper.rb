module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friendship(ids)
    friend=User.find_by_id(ids)
    friendship = Friendship.find_by(user: current_user, friend: friend)
    inverse_friendship = Friendship.find_by(user: friend , friend: current_user)
    if friendship.nil? && inverse_friendship.nil?
     link_to('Send Friend request', new_user_friendship_path(ids)) 

   else destroy_friend_request(friend.id)
    end
  end


  def destroy_friendship(ids)
    friend=User.find_by_id(ids)
    friendship = Friendship.find_by(user: current_user, friend: friend)
    inverse_friendship = Friendship.find_by(user: friend , friend: current_user)
    link_to('delete friendship!', user_friendship_path(friend.id, friendship.id), method: :delete) unless friendship.nil?
    link_to('delete friendship!', user_friendship_path(friend.id, inverse_friendship.id), method: :delete) unless inverse_friendship.nil?
  end

    def destroy_friend_request(ids)
    friend=User.find_by_id(ids)
    friendship = Friendship.find_by(user: current_user, friend: friend)
    inverse_friendship = Friendship.find_by(user: friend , friend: current_user)
    link_to('cancel friend_request!', user_friendship_path(friend.id, inverse_friendship.id), method: :delete) unless inverse_friendship.nil?
    link_to('cancel friend_request!', user_friendship_path(friend.id, friendship.id), method: :delete) unless friendship.nil?
  end
  def refuse_friend_request(ids)
    friend=User.find_by_id(ids)
    friendship = Friendship.find_by(user: current_user, friend: friend)
    inverse_friendship = Friendship.find_by(user: friend , friend: current_user)
    link_to('Refuse friend_request!', user_friendship_path(friend.id, friendship.id), method: :delete) unless friendship.nil?
    link_to('Refuse friend_request!', user_friendship_path(friend.id, inverse_friendship.id), method: :delete) unless inverse_friendship.nil?
  end
end
