class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create

  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.reverse_order
  end

  def update
  end

  private
  def user_params
  end
end