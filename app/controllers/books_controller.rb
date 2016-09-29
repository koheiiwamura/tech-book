class BooksController < ApplicationController

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(8)
  end

  def new
    @book = Book.new
    # @book.images.build
  end

  def create
    binding.pry
    @book = Book.new(create_params)
    if @book.save
      redirect_to root_path,notice:"投稿しました"
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
  end

  private
  def create_params
    params.require(:book).permit(:image,:title,:content,:state,:price,:postage).merge(user_id:current_user.id, tag_list: params[:book][:tag])
  end
end

# :images_attributes: [:image]
