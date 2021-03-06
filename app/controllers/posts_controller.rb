class PostsController < ApplicationController

  def new
    @post = current_user.posts.new
    @post.build_spot
  end

  def index
    @post = Post.all
    @tag_list = Tag.all
    @home_posts = @post.where(place: 0)
    @shop_posts = @post.where(place: 1)
    @post = current_user.posts.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
    @post_tags = @post.tags
    @lat = @post.spot.latitude
    @lng = @post.spot.longitude
    gon.lat = @lat
    gon.lng = @lng
  end

  def create
    @post = current_user.posts.new(post_params)
    @tag_list = params[:post][:tag_name].split(nil)
    if @post.save
      @post.save_tag(@tag_list)
      tags = Vision.get_image_data(@post.post_image)
    tags.each do |tag|
      @post.tags.create(tag_name: tag)
    end
      redirect_to posts_path, notice: '投稿に成功しました。'
    else
      flash.now[:alert] = '投稿が失敗しました。'
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to posts_path
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end

  def home_posts
    @home_posts = Post.where(place: 0)
  end

  def shop_posts
    @shop_posts = Post.where(place: 1)
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :post_image, :text, :place, :genre, spot_attributes: [:address])
  end
end