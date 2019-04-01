class Admin::SuggestsController < ApplicationController
  before_action :logged_in_user
  before_action :load_suggest, only: :update

  def index
    @suggests = Suggest.includes(:user).newest.paginate page: params[:page],
      per_page: Settings.per_page
    respond_to do |format|
      format.html
      format.csv { send_data @suggests.to_csv}
      format.xls { send_data @suggests.to_csv(col_sep: "\t") }
    end
    @q = Suggest.ransack params[:q]
    @suggests = @q.result.newest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def update
    @suggest.status = params[:value]
    if @suggest.save
      flash[:success] =  t "suggest.updated", value: @suggest.status
    else
      flash[:danger] = t "unsuccessful"
    end
    redirect_to admin_suggests_path
  end

  private

  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    return if @suggest
    flash[:danger] = t "no_data_suggest"
    redirect_to root_path
  end
end
