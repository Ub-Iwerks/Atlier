class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_work_search

  private

  def work_search_params
    params.require(:work_search).permit(:keyword)
  end

  def set_work_search
    @work_search = WorkSearch.new
  end
end
