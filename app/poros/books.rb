class Books
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books

  def initialize(location, forecast, total_books_found, list_of_books)
    @destination = location
    @forecast = forecast
    @total_books_found = total_books_found
    @books = list_of_books
  end
end