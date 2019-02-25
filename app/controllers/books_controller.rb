class BooksController < ApplicationController
  def show
    book = Book.find(params[:id])
    book = EPUB::Parser.parse(book.link)
    current_page = book.each_page_on_spine { |page| puts page }[11]
    render inline: current_page.read
  end
end
