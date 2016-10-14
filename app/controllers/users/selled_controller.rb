class Users::SelledController < ApplicationController
  def index
    @books = Book.where(user_id: current_user.id).page(params[:page]).per(8)
  end
end
