class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  def show
    @user = User.find(params[:id])
    @works = @user.works.includes(
      [
        :likes,
        :comments,
        image_attachment: :blob,
        illustrations: [photo_attachment: :blob],
      ]
    ).page(params[:page])
  end

  def index
    @users = User.select(
      :id,
      :username,
    ).includes(
      [
        :works,
        avatar_attachment: :blob,
      ]
    ).page(params[:page])
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.select(
      :id,
      :username,
    ).includes(
      [
        :works,
        avatar_attachment: :blob,
      ]
    ).page(params[:page])
    render "show_follow"
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.select(
      :id,
      :username,
    ).includes(
      [
        :works,
        avatar_attachment: :blob,
      ]
    ).page(params[:page])
    render "show_follow"
  end

  def favorites
    @user = User.includes(
      [
        likes: [
          work: [
            :likes,
            comments: :user,
            image_attachment: :blob,
            user: [avatar_attachment: :blob],
            illustrations: [photo_attachment: :blob],
          ],
        ],
      ]
    ).find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
