# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  prepend_before_action :authenticate_scope!, only: [:edit, :edit_password, :update, :update_password, :destroy]
  prepend_before_action :set_minimum_password_length, only: [:new, :edit, :edit_password]

  def new
    super do
    end
  end

  def create
    super
  end

  def edit
  end

  def update
    super
  end

  def destroy
    super
  end

  def edit_password
  end

  def update_password
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    resource_updated = restricted_update_resource(resource, account_update_params)
    if resource_updated
      flash[:success] = "パスワードを変更しました"
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      redirect_to edit_user_registration_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      render "edit_password"
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar, :description, :website])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def restricted_update_resource(resource, params)
    resource.update_with_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
