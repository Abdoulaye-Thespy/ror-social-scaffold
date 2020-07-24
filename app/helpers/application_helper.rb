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

  def friendship(user)
    if !@pend_friends.nil? && @pend_friends.include?(user)
      return "invitation sent"
    elsif !@req_friends.nil? && @req_friends.include?(user)
      link_to 'Accept invitation', new_user_friendship_path(user.id)
    elsif !@friends.nil? && @friends.include?(user)
      return "friends"
    else
    link_to('Send Friend request', new_user_friendship_path(user.id))
    end
  end

  def destroy_friendship(user)
     if !@pend_friends.nil? && @pend_friends.include?(user)
     link_to('cancel request!', user_friendship_path(user.id, user.id), method: :delete)
    elsif @req_friends.include?(user)
      link_to('refuse request!', user_friendship_path(user.id, user.id), method: :delete)
    elsif @friends.include?(user)
      link_to('remove friend', user_friendship_path(user.id, user.id), method: :delete)
    else
      return " block this user"
    end
   
  end


end
