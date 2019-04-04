class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit destroy index)
  before_action :load_user, except: :index
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  authorize_resource

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.user.per_page
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv}
      format.xls { send_data @users.to_csv(col_sep: "\t") }
    end
  end

  def show
    @follow = current_user.active_relationships.build
    @unfollow = current_user.active_relationships.find_by(followed_id: @user.id)
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

  def update_role
    if @user.user?
      @user.update role: "admin"
      flash[:success] = t "setadmin"
      redirect_to @user
    elsif @user.admin?
      @user.update role: "user"
      flash[:success] = t "destroy_admin"
      redirect_to @user
    else
      flash[:danger] = t "set_fail"
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
      :password_confirmation, :phone, :address, :role
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "login_plz"
    redirect_to new_user_session_path
  end

  def correct_user
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
