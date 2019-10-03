class BookMailer < ApplicationMailer
  def daily_book_pages
    book = Book.find(1)
    epub = EPUB::Parser.parse(book.link)
    current_page = epub.each_page_on_spine { |page| puts page }[book.current_reading_page]
    book.update(current_reading_page: book.current_reading_page + 1)
    @content = current_page.read
    mail to: "benii.muresan@gmail.com", subject: 'Book'
  end
end
