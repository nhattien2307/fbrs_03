class FavoritesController < ApplicationController
  before_action :load_favorite, only: :destroy

  def create
    @favorite = current_user.favorites.build favorites_params
    if @favorite.save
      target_activity @favorite
      flash[:success] = t "favorites.favorite_success"
    else
      flash[:danger] = t "favorites.favorite_fail"
    end
    redirect_to @favorite.book
  end

  def destroy
    if @favorite.destroy
      target_activity @favorite
      flash[:success] = t "favorites.unfavorite_success"
    else
      flash[:danger] = t "favorites.unfavorite_fail"
    end
    redirect_to @favorite.book
  end

  private

  def favorites_params
    params.require(:favorite).permit :book_id
  end

  def load_favorite
    @favorite = current_user.favorites.find_by book_id: params[:book_id]
    return if @favorite
    flash[:danger] = t "no_data_favorite"
    redirect_to root_path
  end
end
