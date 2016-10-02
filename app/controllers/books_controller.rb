class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(8)
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
    params.require(:book).permit(:image,:title,:content,:state,:price,:postage).merge(user_id:current_user.id, tag_list: params[:book][:tag])
  end
  def update_params
    params.require(:book).permit(:image,:title,:content,:state,:price,:postage).merge(user_id:current_user.id, tag_list: params[:book][:tag])
  end
  def set_book
    @book = Book.find(params[:id])
  end
end

# :images_attributes: [:image]
