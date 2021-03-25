class WorksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :new, :show]
  before_action :correct_user, only: [:destroy]

  def show
    @work = Work.find(params[:id])
    @user = @work.user
    @illustrations = @work.illustrations
    @comments = @work.comments.order(created_at: "ASC")
    @comment = current_user.comments.build
    @like = Like.new
  end

  def new
    @work_create_form = WorkCreateForm.new
  end

  def create
    @work_create_form = WorkCreateForm.new(work_create_form_params)
    if @work_create_form.save
      flash[:success] = "投稿に成功しました。"
      work = Work.first
      redirect_to work_path work
    else
      flash[:danger] = "投稿に失敗しました。"
      render "new"
    end
  end

  def destroy
    @work.destroy
    flash[:success] = "削除しました。"
    redirect_back(fallback_location: root_url)
  end

  private

  def work_create_form_params
    params.require(:work_create_form).permit(
      :title,
      :concept,
      :description,
      :image,
      :illustration_name,
      :illustration_description,
      :illustration_photo,
      :current_user_id
    )
  end

  def correct_user
    @work = current_user.works.find_by(id: params[:id])
    redirect_to root_url if @work.nil?
  end
end
