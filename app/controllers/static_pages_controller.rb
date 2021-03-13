class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @work = current_user.works.build
      @feed_items = current_user.feed.page(params[:page]).per(20)
    end
  end

  def contact
  end
end
