class CommentsController < ApplicationController
  def create
    @comment = Comment.create(create_params)
    set_comments
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    set_comments
  end

  private

  def create_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, book_id: params[:book_id])
  end

  def set_comments
    @book = Book.find(params[:book_id])
    @comments = @book.comments.includes(:user).page(params[:page]).per(8).order("id DESC")
  end
end
