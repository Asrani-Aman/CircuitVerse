# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  prepend_before_action :check_captcha, only: [:create]

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    if resource.pre_existing_user? && !resource.confirmed? && resource.within_grace_period?
      flash[:warning] = "Radhe Radhe Om Shanti Shivbaba Maa. Please verify your email to maintain uninterrupted access."
    end
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  private

  def check_captcha
    if Flipper.enabled?(:recaptcha) && !verify_recaptcha
      self.resource = resource_class.new sign_in_params
      respond_with_navigational(resource) { render :new }
    end
  end
end