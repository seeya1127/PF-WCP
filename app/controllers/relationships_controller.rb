class RelationshipsController < ApplicationController
  def create

   follow = current_user.active_relationships.new(follower_id: params[:user_id])
   follow.save
   @user.create_notification_follow(current_user)
   redirect_to request.referer
  end

  def destroy
   follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
   follow.destroy
   redirect_to request.referer
  end
end
