class BookFacade
  def get_book(search, quantity)
    list_book_data(search, quantity)[:docs].map do |book_data|
      Book.new(book_data)
    end
  end

  private
  def list_book_data(search, quantity)
    @list_book_data ||= service.get_book(search, quantity)
  end

  def service
    @service ||= BookService.new
  end
end