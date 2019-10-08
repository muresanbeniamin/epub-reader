class BookPagesController < ApplicationController
  def show
    book_page = BookPage.find(params[:id])
    render json: book_page
  end
end
