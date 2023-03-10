class InvitationsController < Devise::InvitationsController

  before_action :update_sanitized_params, only: [:update, :new, :create]

  # PUT /resource/invitation
  def update
    respond_to do |format|
      format.js do
        invitation_token = Devise.token_generator.digest(resource_class, :invitation_token, update_resource_params[:invitation_token])
        self.resource = resource_class.where(invitation_token: invitation_token).first
        resource.skip_password = true
        resource.update_attributes update_resource_params.except(:invitation_token)
      end
      format.html do
        super
      end
    end
  end


  protected

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :project_id, :role])
  end
end