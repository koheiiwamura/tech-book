class OrdersController < ApplicationController
  before_action :check_logined
  before_action :check_orderd, only: [:new, :create]
  before_action :check_user, only: [:show]
  before_action :check_card, only: [:create]
  before_action :set_book, only: [:new, :create, :show]

  def new
    @address = Address.where(user_id: current_user.id).first_or_create
    @order = Order.new
    session[:return_to] = request.url
  end

  def create
    @order_detail = OrderDetail.new(detail_params)
    @order_detail.save
    @order = Order.new(
      buyer_id: current_user.id, book_id: params[:book_id],
      order_detail_id: @order_detail.id, seller_id: @book.user_id,
      payment_method: params[:order][:payment_method]
      )
    if @order.save
      redirect_to book_order_path(id: @order.id, book_id: @book.id)
    else
      flash[:alert] = "購入することができませんでした"
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @books = @user.books_of_buyer
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_detail
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def detail_params
    params.require(:order_detail).permit(
      :last_name, :first_name, :email,
      :phone_number, :postal_code, :street_address,
      :payment_method, :accept_booking)
  end

  def check_card
    if params[:order][:payment_method] == "クレジットカード" && params["webpay-token"] == ""
      flash[:alert] = "カード情報を入力してください"
      redirect_to :back
    end
  end

  def check_logined
    redirect_to root_path, alert: "ログインしてください" unless user_signed_in?
  end

  def check_user
    redirect_to root_path, alert: "表示できません" if current_user != Order.find(params[:id]).buyer
  end

  def check_orderd
    if Book.find(params[:book_id]).order
      redirect_to book_path(id: params[:book_id]), alert: "この本は売り切れです"
    end
    if Book.find(params[:book_id]).user == current_user
      redirect_to root_path, alert: "自分の本を買うことはできません"
    end
  end
end
