class Book
  attr_reader :title,
              :publisher,
              :isbn
              
  def initialize(book_data)
    @title = book_data[:title]
    @publisher = book_data[:publisher]
    @isbn = book_data[:isbn]
  end
end