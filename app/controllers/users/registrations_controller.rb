class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

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
  private
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
  end
end