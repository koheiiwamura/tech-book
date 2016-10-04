class Books::SearchController < ApplicationController
  def index
    search_books
  end

  private
  def search_books
    if params[:category].present?
      if params[:word].present?
        @books = Book.where(category: params[:category]).where('title LIKE(?)',"%#{params[:word]}%").page(params[:page]).per(8)
      else
        @books = Book.where(category: params[:category]).page(params[:page]).per(8)
      end
    else
      if params[:word].present?
        @books = Book.where('title LIKE(?)',"%#{params[:word]}%").page(params[:page]).per(8)
      else
        # flash[:alert] = "カテゴリーもしくはワードを入力してください"
      end
    end
  end
end