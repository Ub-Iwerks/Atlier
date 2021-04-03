class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @comment.work.create_notification_comment(current_user, @comment.id)
      flash[:success] = "コメントしました！"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "コメントに失敗しました"
      @work = Work.find(params[:comment][:work_id])
      redirect_to work_path @work
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: root_url)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :work_id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
