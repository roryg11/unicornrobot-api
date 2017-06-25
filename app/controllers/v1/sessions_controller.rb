module V1
  #  need to handroll own authetnciation process the way we did in old apps and use json web
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    # POST /v1/login
    def create
      @user = User.find_for_database_authentication(email: params[:username])
      return invalid_login_attempt unless @user

      if @user.valid_password?(params[:password])
        sign_in @user
        render json: @user, serializer: SessionSerializer, root: nil
      else
        invalid_login_attempt
      end
    end

    # DELETE /v1/logout
    def destroy
      isSignedOut = sign_out(current_user)
      if isSignedOut
        render json: isSignedOut
      else
        render json: {error: t('sessions_controller.user_could_not_be_signed_out')}, Status: :unprocessable_entity
      end
    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {error: t('sessions_controller.invalid_login_attempt')}, Status: :unprocessable_entity
    end
  end
end
