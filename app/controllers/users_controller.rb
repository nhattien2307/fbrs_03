class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)

  def index; end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user.created"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.deleted"
      redirect_to users_path
    else
      flash[:danger] = t "user.unsuccessfully_delete"
      redirect_to root_path
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "no_data"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :phone, :address
  end
end
