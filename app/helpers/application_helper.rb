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
    if friendship.nil?
     link_to('Send Friend request', new_user_friendship_path(ids))
    elsif friendship.confirmed==false
     link_to('Friend request sent', new_user_friendship_path(ids)) 
    end
  end
end
