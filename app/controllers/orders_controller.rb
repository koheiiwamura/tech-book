class OrdersController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @address = Address.where(user_id: current_user.id).first_or_create
    @order = Order.new
  end

  def create
  end

end
