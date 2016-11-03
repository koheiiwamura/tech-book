class UsersController < ApplicationController
  before_action :set_user
  before_action :set_bought_books
  before_action :check_logined
  before_action :check_user, only: :edit

  def show
    @favorite_books = @user.like_books.includes(:order).page(params[:page]).per(8).order("id DESC")
    @selled_books = @user.books.includes(:order).page(params[:page]).per(8).order("id DESC")
    session[:return_to] = request.url
  end

  def edit
    @address = Address.where(user_id: @user.id).first_or_create
    @bank = Bank.where(user_id: @user.id).first_or_create
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_bought_books
    @bought_books = @user.books_of_buyer.includes(:order).page(params[:page]).per(8).order("id DESC")
  end

  def check_logined
    redirect_to root_path, alert: "ログインしてください" unless user_signed_in?
  end

  def check_user
    redirect_to root_path, alert: "異なるユーザー情報を編集することができません" if @user != current_user
  end

end
