class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id
    @comment_post = @comment.post
    @comment.save
    post.create_notification_comment!(current_user, @comment.id)
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_text)
  end
end
