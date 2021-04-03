class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :notification_chekced
  def index
    @notifications = current_user.passive_notifications.page(params[:page])
  end

  private

  def notification_chekced
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
