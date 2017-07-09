module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create, :index, :show, :update, :destroy, :current_user]
    before_action :signed_in

    # POST /v1/users
    #  creates a user
    def create
      @user = User.new(user_params)
      @user.assignUserGroup()
      errors = t('user_create_error')
      if @user.valid? == false
        errors = @user.errors.full_messages.uniq
      end
      if @user.save
        render json: @user, serializer: V1::UserSerializer, status: 201
      else
        render json: { error: errors}, status: :unprocessable_entity
      end
    end

    def profile
      render json: current_user, serializer: V1::UserSerializer, status: 201
    end

    # GET /v1/users
    def index
      @users = User.all
      render json: @users, each_serializer: V1::UserSerializer
    end

    def show
      @user = User.find_by_id(params[:id])
      if @user
        render json: @user, serializer: V1::UserSerializer
      else
        render json: {error: t('User could not be found')}, status: 404
      end
    end

    def update
      puts current_user
      if current_user.role != roles.ADMIN || current_user.id != params[:id]
        render json: { error:  t('unauthorized action')}, status: 401
      end

      @user = User.find_by_id(params[:id])
      errors = t('user_update_error')
      @user.update(user_params)

      if @user.valid?
        render json: @user, serializer: V1::UserSerializer
      else
        puts @user.errors.full_messages
        errors = @user.errors.full_messages.uniq
        render json: { error: errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @user = User.find_by_id(params[:id])
      @user.destroy
      head :no_content
    end


    private

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :bio,
        :jump_to,
        :jump_from,
        :password,
        :password_confirmation,
        :username
      )
    end

  end
end
