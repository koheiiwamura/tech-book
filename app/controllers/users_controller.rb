class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_logined, only:[:show, :edit, :update]
  before_action :check_user, only: [:edit, :update]
  def show
    @favorite_books = @user.like_books.includes(:order).page(params[:page]).per(8).order("id DESC")
    @selled_books = @user.books.includes(:order).page(params[:page]).per(8).order("id DESC")
    @bought_books = @user.books_of_buyer.includes(:order).page(params[:page]).per(8).order("id DESC")
  end
  def edit
    @address = Address.where(user_id: @user.id).first_or_create
    @bank = Bank.where(user_id: @user.id).first_or_create
    @books = @user.books_of_buyer.page(params[:page]).per(8).order("id DESC")
  end

  private
  def set_user
    @user = User.find(params[:id])
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
