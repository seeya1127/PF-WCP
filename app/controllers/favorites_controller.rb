class FavoritesController < ApplicationController

  def create
    unless current_user.favorites.find_by(post_id: params[:post_id])
      @post = Post.find(params[:post_id])
      favorite = current_user.favorites.new(post_id: params[:post_id])
      # @post.create_notification_favorite!(current_user)
      # @item.create_notification_by(current_user)
      favorite.save
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
  end

end
