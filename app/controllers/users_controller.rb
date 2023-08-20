class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @user = User.find(params[:id])
    @works = @user.works.
      select("works.*, SUM(footprints.counts) AS total_footprint_counts").
      joins(:footprints).
      includes(
        [
          :likes,
          :comments,
          image_attachment: :blob,
          illustrations: [photo_attachment: :blob],
        ]
      ).group("works.id").
      page(params[:page])
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
    @user = User.includes(:likes).find(params[:id])
    @works = Work.
      select("works.*, likes.user_id, sum(footprints.counts) as total_footprint_counts").
      joins(:likes, :footprints).
      includes(
        [
          :comments,
          image_attachment: :blob,
          user: { avatar_attachment: :blob },
          illustrations: { photo_attachment: :blob },
        ]
      ).where("likes.user_id = ?", @user.id).
      group("works.id").
      page(params[:page])

    respond_to do |format|
      format.js
    end
  end

  def my_works
    @user = User.find(params[:id])
    @works = @user.works.
      select("works.*, sum(footprints.counts) as total_footprint_counts").
      joins(:footprints).
      includes(
        [
          :likes,
          :comments,
          image_attachment: :blob,
          illustrations: [photo_attachment: :blob],
        ]
      ).group("works.id").
      page(params[:page])

    respond_to do |format|
      format.js
    end
  end

  def stocks
    @user = User.find(params[:id])
    @works = Work.
      select("works.*, stocks.user_id, sum(footprints.counts) as total_footprint_counts").
      joins(:stocks, :footprints).
      includes(
        [
          :comments,
          :likes,
          image_attachment: :blob,
          user: { avatar_attachment: :blob },
          illustrations: { photo_attachment: :blob },
        ]
      ).where("stocks.user_id = ?", @user.id).
      group("works.id").
      page(params[:page])

      respond_to do |format|
        format.js
      end
  end
end
