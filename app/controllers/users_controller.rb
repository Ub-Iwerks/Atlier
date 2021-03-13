class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @works = @user.works.page(params[:page]).per(20)
  end
end
