# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  private

  def respond_with(_resource, _opts = {})
    render json: { message: 'Login successful.',
                   user: { id: @user.id,
                           role: @user.role,
                           profileComplete: @user.user_profile.present? } },
           status: :ok
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Something went wrong.' }, status: :unauthorized
  end
end

# before_action :configure_sign_in_params, only: [:create]

# GET /resource/sign_in
# def new
#   super
# end

# POST /resource/sign_in
# def create
#   super
# end

# DELETE /resource/sign_out
# def destroy
#   super
# end

# protected

# If you have extra params to permit, append them to the sanitizer.
# def configure_sign_in_params
#   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
# end
