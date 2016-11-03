class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "パスワードをリセットする"
  end
  def facebook_password(user)
    @user = user
    mail :to => user.email, :subject => "Facebook認証でのパスワード設定"
  end
end
