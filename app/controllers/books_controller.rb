class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update,:destroy]
  before_action :check_orderd, only: [:edit, :update]

  def index
    @books = Book.all.includes(:order).page(params[:page]).per(8).order("id DESC")
    @like = current_user.likes.find_by(book_id: params[:id]) if current_user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to root_path,notice:"投稿しました"
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @like = current_user.likes.find_by(book_id: params[:id]) if current_user
    if @book.order
      @order = @book.order
      @order_detail = @order.order_detail
    end
    @related_books = Book.where(category: @book.category).where.not(id: @book.id).includes(:order).order("RAND()").limit(3)
    @comment = Comment.new
    @comments = @book.comments.includes(:user).page(params[:page]).per(8).order("id DESC")
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to root_path, notice:"更新しました"
    else
      flash[:alert] = "更新できませんでした"
      render :edit
    end
  end

  def destroy
    if current_user.id == @book.user_id
      @book.destroy
      redirect_to root_path, notice:"削除しました"
    else
      redirect_to root_path, alert:"削除できませんでした"
    end
  end

  private

  def book_params
    params.require(:book).permit(
      :image, :title, :content,
      :category, :state,:price,:postage).merge(user_id:current_user.id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def check_user
    redirect_to root_path, alert:"出品者以外編集できません" if @book.user.id != current_user.id
  end

  def check_orderd
    redirect_to root_path, alert:"取引が終了のため、更新できません" if @book.order
  end
end
