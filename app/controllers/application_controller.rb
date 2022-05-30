class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      user_path(resource)
    else
      super
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:new_contact) do |u|
      u.permit(:name, :relationship)
    end
  end
end
