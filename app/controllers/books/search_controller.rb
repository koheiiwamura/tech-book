class Books::SearchController < ApplicationController
  def index
    search_books
  end

  private
  def search_books
    if params[:category].present?
      if params[:word].present?
        @books = Book.where(category: params[:category]).where('title LIKE(?)',"%#{params[:word]}%").page(params[:page]).per(9)
      else
        @books = Book.where(category: params[:category]).page(params[:page]).per(9)
      end
    else
      if params[:word].present?
        @books = Book.where('title LIKE(?)',"%#{params[:word]}%").page(params[:page]).per(9)
      else
      end
    end
  end
end