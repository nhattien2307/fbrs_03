class SuggestsController < ApplicationController
  before_action :logged_in_user
  before_action :load_suggest, only: :destroy
  before_action :suggest_by_user, only: :index
  authorize_resource

  def index; end

  def new
    @suggest = Suggest.new
  end

  def create
    @suggest = current_user.suggests.new suggest_params
    if @suggest.save
      SendEmailJob.set(wait: 5.seconds).perform_later(@suggest)
      flash[:success] = t "suggest.created"
      redirect_to suggests_path(user_id: current_user)
    else
      flash[:danger] = t "unsuccessful"
      render :new
    end
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t "suggest.deleted"
      redirect_to suggests_path(user_id: current_user)
    else
      flash[:danger] = t "suggest.unsuccessfully_delete"
      redirect_to root_path
    end
  end

  private

  def suggest_params
    params.require(:suggest).permit :name_book,
      :publisher, :author, :category, :number_page
  end

  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    return if @suggest
    flash[:danger] = t "no_data_suggest"
    redirect_to root_path
  end

  def suggest_by_user
    @suggests = Suggest.newest.by_user(current_user)
  end
end
