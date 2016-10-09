class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update,:destroy]
  before_action :check_orderd, only: [:edit, :update]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(8).order("id DESC")
    if current_user
      @like = Like.find_by(user_id: current_user.id, book_id: params[:id])
    end
  end

  def new
    @book = Book.new
    # @book.images.build
  end

  def create
    @book = Book.new(create_params)
    if @book.save
      redirect_to root_path,notice:"投稿しました"
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    if current_user
      @like = Like.find_by(user_id: current_user.id, book_id: params[:id])
    end
    @related_books = Book.where(category: @book.category).where.not(id: @book.id).order("RAND()").limit(3)
  end

  def edit
  end

  def update
    if @book.update(update_params)
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
  def create_params
    params.require(:book).permit(:image,:title,:content, :category, :state,:price,:postage).merge(user_id:current_user.id)
  end
  def update_params
    params.require(:book).permit(:image,:title,:content, :category, :state,:price,:postage).merge(user_id:current_user.id)
  end
  def set_book
    @book = Book.find(params[:id])
  end
  def check_user
    if @book.user.id != current_user.id
      redirect_to root_path, alert:"出品者以外編集できません"
    end
  end
  def check_orderd
    if @book.order.present?
      redirect_to root_path, alert:"取引が終了のため、更新できません"
    end
  end

end