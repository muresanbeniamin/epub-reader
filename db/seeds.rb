user = User.create(first_name: 'Dummy', last_name: 'User', email: 'dummy@email.com')
book = Book.create(link: "../epub-reader/public/books/rpo.epub", name: "Ready Player One")
UserBook.create(user: user, book: book)
