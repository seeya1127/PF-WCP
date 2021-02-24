class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id
    @comment_post = @comment.post
    @comment.save
    @comments = post.comments
    # post.create_notification_comment!(current_user, @comment.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_text)
  end
end
