class BooksFacade
  def initialize(location, quantity)
    @destination = location
    @quantity_index = quantity - 1
  end

  def get_book
    Books.new(@destination, forecast, total_books_found, list_of_books)
  end

  private
  def total_books_found
    book_search[:numFound]
  end

  def list_of_books
    book_from_library = book_search[:docs][0..@quantity_index]
    book_from_library.map do |book|
      Book.new(book)
    end
  end

  def forecast
    {
      summary: current_weather[:text],
      temperature: current_weather[:temp]
    }
  end

  def current_weather
    forecast_data.current_weather
  end

  def forecast_data
    @_forecast ||= ForecastFacade.new.get_forecast(@destination)
  end

  def book_search
    @_book_search ||= service.list_book(@destination)
  end

  def service
    @_service ||= BooksService.new
  end
end