class OrdersController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @address = Address.where(user_id: current_user.id).first_or_create
    @order = Order.new
    @order_detail = OrderDetail.new
  end

  def create
    @order_detail = OrderDetail.new(detail_params)
    @order_detail.save
    @book = Book.find(params[:book_id])
    @order = Order.new(buyer_id: current_user.id, book_id: params[:book_id], order_detail_id: @order_detail.id,seller_id: @book.user_id)
    @order.save
  end

  private
  def detail_params
    params.require(:order_detail).permit(:last_name, :first_name, :email, :phone_number, :postal_code, :street_address)
  end
end
