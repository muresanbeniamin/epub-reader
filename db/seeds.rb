book = Book.create(link: "../epub-reader/public/books/rpo.epub", name: "Ready Player One")

# Create Book Pages
EPUB::Parser.parse(book.link).each_page_on_spine do |epage|
  page = BookPage.create(book: book, content: epage.read)
  book.book_pages << page
end