class Book
  attr_reader :title,
              :isbn,
              :publisher

  def initialize(book_data)
    @title = book_data[:docs][0][:title]
    @isbn = book_data[:docs][0][:isbn]
    @publisher = book_data[:docs][0][publisher]
  end
end