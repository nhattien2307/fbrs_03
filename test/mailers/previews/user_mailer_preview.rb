class UserMailerPreview < ActionMailer::Preview
# http://localhost:3000/rails/mailers/user_mailer/suggest_confirm
  def suggest_confirm
    user = User.last
    suggest = user.suggests.last
    UserMailer.suggest_confirm(user, suggest)
  end
end
