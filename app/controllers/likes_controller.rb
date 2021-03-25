class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @like = current_user.likes.create(work_id: params[:work_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(work_id: params[:work_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
