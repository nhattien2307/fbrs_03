class BooksController < ApplicationController
  before_action :logged_in_user, only: %i(new edit)
  before_action :find_book, except: %i(index new create findfavorite)
  before_action :build_favorite, except: %i(index new create findfavorite)
  before_action :book_favorite_by_user, only: :findfavorite

  def index
    @books = Book.by_categories(params[:category_id]).newest.paginate page:
      params[:page], per_page: Settings.per_page
    return @books = @books.search_by(params[:search]) if params[:search]
  end

  def findfavorite
    @book_favorites = Book.by_book_favorite(@book_favorite)
  end

  def new
    @book = Book.new
  end

  def show
    return if @book.reviews.blank?
    @book.avg_rate = @book.reviews.average(:rate)
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "book.created"
      redirect_to books_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update book_params
      flash[:success] = t "book.edited"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "book.delete_book"
      redirect_to books_path
    else
      flash[:danger] = t "book.unsuccessfully_delete"
      redirect_to root_path
    end
  end

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "login_plz"
    redirect_to login_path
  end

  def book_params
    params.require(:book).permit :title, :content, :category_id, :author,
      :quanlity, :book_img
  end

  def build_favorite
    @favorite = @book.favorites.new
  end

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "no_data"
    redirect_to root_path
  end

  def book_favorite_by_user
    @book_favorite = current_user.favorites.pluck(:book_id)
  end
end
