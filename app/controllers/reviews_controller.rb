class ReviewsController < ApplicationController
  before_action :logged_in_user, only: %i(new edit)
  before_action :find_book
  before_action :find_review, except: %i(new create)

  def new
    @review = Review.new
  end

  def create
    @review = @book.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = t "review.created"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "unsuccessful"
      render :new
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      flash[:success] = t "review.edited"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "unsuccessful"
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "review.deleted"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "review.unsuccessfully_delete"
      redirect_to root_path
    end
  end

  private

  def review_params
    params.require(:review).permit :rate, :content
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "no_data"
    redirect_to root_path
  end

  def find_review
    @review = Review.find_by id: params[:id]
    return if @review
    flash[:danger] = t "no_data"
    redirect_to root_path
  end
end
