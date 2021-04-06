class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers, :index]
  def show
    @user = User.find(params[:id])
    @works = @user.works.page(params[:page])
  end

  def index
    @users = User.all.page(params[:page])
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render "show_follow"
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render "show_follow"
  end
end
