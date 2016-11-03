class LikesController < ApplicationController
  def create
    @like = Like.create(create_params)
    set_book
  end

  def destroy
    @like = current_user.likes.find_by(book_id: params[:book_id])
    @like.destroy
    set_book
  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end

  def create_params
    params.permit(:book_id).merge(user_id: current_user.id)
  end
end
