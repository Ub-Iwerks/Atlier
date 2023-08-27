class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(title: params[:title])
    if !@tag.present?
      flash[:danger] = "そんなtagないですやん"
      redirect_to root_url
    end
  end
end
