class FavoritesController < ApplicationController
  def create
    unless current_user.favorites.find_by(post_id: params[:post_id])
      favorite = current_user.favorites.new(post_id: params[:post_id])
      favorite.save
    end
    redirect_to request.referer
  end

  def destroy
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
    redirect_to request.referer
  end
end
