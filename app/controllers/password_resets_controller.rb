class PasswordResetsController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "入力したアドレスにメールを送信しました"
  end

  def edit
  end

  def update
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif
     @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      redirect_to root_url, :notice => "パスワードがリセットされました。"
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find_by_password_reset_token!(params[:id])
  end
end
