class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
      build_resource(sign_up_params)
      if resource.save
          yield resource if block_given?
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
            respond_with resource, location: after_sign_up_path_for(resource)
          else
            expire_data_after_sign_in!
            respond_with resource, location: root_path
          end
      else
          clean_up_passwords resource
          flash[:alert] = "新規登録できませんでした。もう一度お試しください"
          redirect_to root_path
      end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
        :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      redirect_to :back, notice:"プロフィールを変更しました。"
    else
      clean_up_passwords resource
      flash[:error] = resource.errors.full_messages
      redirect_to :back, notice: "変更できませんでした。"
    end
  end

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user, :email])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
