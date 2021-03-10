# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  def new
    super
  end

  def create
    super
  end

  def show
    super
  end

  protected

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    user_path(resource)
  end
end
