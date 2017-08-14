module V1
  class PasswordResetsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      user = User.find_by_email(params[:email].downcase())
      user.send_password_reset if user
      render json: true, status: 201
    end

    def update
      @user = User.find_by_reset_password_token(params[:id])
      if @user.reset_password_sent_at < 2.hours.ago
        render json: {error: t('password_resets_controller. Token has expired')}, status: :unprocessable_entity
      elsif @user.update_attributes({password: params[:password]})
        render json: @user, status: 201
      end
    end
  end
end
