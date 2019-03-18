class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(new edit)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :load_unfollow, :load_follow, only: %i(show following followers)

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

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

  def following
    @title = t "following"
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.follow.per_page
    render :show_follow
  end

  def followers
    @title = t "followers"
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.follow.per_page
    render :show_follow
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

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "login_plz"
    redirect_to login_path
  end

  def correct_user
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_unfollow
    @unfollow = current_user.active_relationships.find_by(followed_id: @user.id)
    return if @unfollow
    flash[:danger] = t "no_data"
    redirect_to root_path
  end

  def load_follow
    @follow = current_user.active_relationships.build
    return if @follow
    flash[:danger] = t "no_data"
    redirect_to root_path
  end
end
