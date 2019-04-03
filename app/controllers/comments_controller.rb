class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(new edit create)
  before_action :find_book
  before_action :find_review
  before_action :find_comment, except: %i(new create)
  authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = @review.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      target_activity @comment
      flash[:success] = t "comment.created"
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def destroy
    if @comment.destroy
      target_activity @comment
      flash[:success] = t "comment.deleted"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "comment.unsuccessfully_delete"
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "no_data_book"
    redirect_to root_path
  end

  def find_review
    @review = Review.find_by id: params[:review_id]
    return if @review
    flash[:danger] = t "no_data_review"
    redirect_to root_path
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "no_data_comment"
    redirect_to root_path
  end
end
