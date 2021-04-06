class WorksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :new, :show]
  before_action :correct_user, only: [:destroy]
  before_action :set_categories, only: [:new, :create, :index, :search]
  before_action :set_work_search, except: :index

  def show
    @work = Work.find(params[:id])
    @user = @work.user
    @illustrations = @work.illustrations
    @comments = @work.comments.order(created_at: "ASC")
    @comment = current_user.comments.build
    @like = Like.new
    @liked = Like.find_by(user_id: current_user.id, work_id: params[:id])
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def new
    @form = WorkCreate.new
  end

  def create
    @form = WorkCreate.new(work_create_params)
    answer = @form.save
    if answer[0]
      flash[:success] = "投稿に成功しました"
      redirect_to work_path(answer[1])
    else
      @crete_errors = answer[1]
      render "new"
    end
  end

  def destroy
    @work.destroy
    flash[:success] = "削除しました。"
    redirect_back(fallback_location: root_url)
  end

  def index
    @work_search = WorkSearch.new(work_search_params)
    @works = @work_search.search.page(params[:page])
  end

  def search
  end

  private

  def work_create_params
    params.require(:work_create).permit(
      :category_id,
      :title,
      :image,
      :user_id,
      :concept,
      :description,
      illustrations_attributes: [
        :name,
        :description,
        :photo,
      ]
    )
  end

  def work_search_params
    params.require(:work_search).permit(
      :keyword,
      :category_id,
      :parent_category_id,
    )
  end

  def correct_user
    @work = current_user.works.find_by(id: params[:id])
    redirect_to root_url if @work.nil?
  end

  def set_categories
    @category_parent_array = Category.where(ancestry: nil)
  end
end
