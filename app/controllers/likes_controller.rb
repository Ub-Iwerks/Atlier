class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @liked = current_user.likes.create(work_id: params[:work_id])
    @work = Work.find_by(id: params[:work_id])
    @work.create_notification_like(current_user)
    respond_to do |format|
      format.html { redirect_to @work }
      format.js
    end
  end

  def destroy
    like = Like.find_by(work_id: params[:work_id], user_id: current_user.id)
    like.destroy
    @work = Work.find(params[:work_id])
    respond_to do |format|
      format.html { redirect_to @work }
      format.js
    end
  end
end
