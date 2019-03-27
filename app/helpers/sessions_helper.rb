module SessionsHelper
  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def current_user? user
    user == current_user
  end

  def favorite? book
    current_user.favorites.find_by(book_id: book.id).present?
  end
end
