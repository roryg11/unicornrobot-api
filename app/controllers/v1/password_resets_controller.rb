module V1
  class PasswordResetsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      user = User.find_by_email(params[:email])
      user.send_password_reset if user
      render json: true, status: 201
    end

    def edit
      @user = User.find_by_password_reset_token(params[:id])
    end

    def update
      @user = User.find_by_password_reset_token(params[:id])
      if @user.password_reset_sent_at < 2.hours.ago
        render json: {error: t('password_resets_controller. Token has expired')}, status: :unprocessable_entity
      elsif @user.update_attributes(params[:user])
        render json: @user, status: 201
      end
    end
  end
end
