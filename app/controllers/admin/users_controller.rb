class Admin::UsersController < ApplicationController

  before_action :fetch_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def new; end

  def show; end

  def create
    result = User::Create.call(params: user_params)

    if result.errors.blank?
      respond_to do |format|
        format.html { redirect_to admin_users_path }
        format.json { render json: result.resource, serializer: UserSerializer, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: ErrorsSerializer.serialize(result.errors), status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    result = User::Update.call(params: user_params, user: @user)

    if result.errors.blank?
      respond_to do |format|
        format.html { redirect_to admin_users_path }
        format.json { render json: result.resource, serializer: UserSerializer, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: ErrorsSerializer.serialize(result.errors), status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path }
      format.json { render json: {message: "User deleted"} }
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name)
  end

  def fetch_user
    @user = User.find(params[:id])
  rescue => e
    render json: { message:  e}, status: :not_found
  end



end
