class BookService
  def get_book(search)
    get_url("/search.json?q=#{search}&limit=5")
  end

  private
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://openlibrary.org')
  end
end