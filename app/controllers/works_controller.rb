class WorksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :new, :show]
  before_action :correct_user, only: [:destroy]
  before_action :set_categories, only: [:new, :create, :index, :search]
  before_action :set_work_search, except: :index

  def show
    @work = Work.
      select("works.*, SUM(footprints.counts) + 1 as total_footprints_count").
      joins(:footprints).
      includes(
        [
          :user,
          comments: :user,
          image_attachment: :blob,
          illustrations: [photo_attachment: :blob],
        ]
      ).find(params[:id])
    @work.create_footprint_by(current_user)
    @recommended_works = Work.
      where("works.id in (?)",
            Footprint.
              select(:work_id).
              joins(:work).
              where.not("footprints.work_id = ?", @work.id).        # 現在閲覧している作品の閲覧履歴は除く
              where.not("footprints.user_id = works.user_id").      # 現在閲覧しているユーザー自身が作成した作品は除く
              where("footprints.user_id in (?)",
                    User.                                           # ユーザーのid群を抽出
                      select(:id).
                      joins(:footprints).
                      where.not("users.id = ?", @work.user.id).     # 現在閲覧している作品を作成したユーザーのidは除外
                      where("footprints.work_id = ?", @work.id)))   # 現在閲覧している作品を閲覧しているユーザーのid群を抽出
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
    redirect_to root_url
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
