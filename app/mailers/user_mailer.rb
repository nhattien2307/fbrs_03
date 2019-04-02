class UserMailer < ApplicationMailer
  def suggest_confirm suggest
    @suggest = suggest
    mail to: suggest.user.email, subject: t("thanks")
  end
end
