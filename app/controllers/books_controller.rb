class BooksController < ApplicationController
  def show
    render inline: 'Hello World'
    # book = Book.find(1)
    # epub = EPUB::Parser.parse(book.link)
    # current_page = epub.each_page_on_spine { |page| puts page }[book.current_reading_page]
    # book.update(current_reading_page: book.current_reading_page + 1)
    # render inline: current_page.read
  end
end
