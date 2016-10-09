class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_logined, only:[:show, :edit, :update]
  before_action :check_user, only: [:edit, :update]
  def show
    @favorite_books = @user.like_books.page(params[:page]).per(8).order("id DESC")
    @selled_books = @user.books.page(params[:page]).per(8).order("id DESC")
    @bought_books = @user.books_of_buyer.page(params[:page]).per(8).order("id DESC")
  end
  def edit
    @address = Address.where(user_id: @user.id).first_or_create
    @bank = Bank.where(user_id: @user.id).first_or_create
    @books = @user.books_of_buyer.page(params[:page]).per(8).order("id DESC")
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
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :postal_code, :street_adress, :phone_number, :avatar)
  end

  def check_logined
   if !(user_signed_in?)
      redirect_to root_path, alert: "ログインしてください"
    end
  end

  def check_user
    if @user != current_user
      redirect_to root_path, alert: "異なるユーザー情報を編集することができません"
    end
  end

end
