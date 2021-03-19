class WorksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @work.destroy
    flash[:success] = "削除しました。"
    redirect_back(fallback_location: root_url)
  end

  private

  def work_params
    params.require(:work).permit(:title, :concept, :description, :image)
  end

  def correct_user
    @work = current_user.works.find_by(id: params[:id])
    redirect_to root_url if @work.nil?
  end
end
