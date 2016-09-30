class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def show
    @books = @user.like_books
  end
  def edit
  end
  def update
    if @user.update(update_params)
      redirect_to root_path,notice:"更新に成功しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end
  def update_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :postal_code, :street_adress, :phone_number, :avatar)
  end
end
