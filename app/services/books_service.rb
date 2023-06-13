class BooksService
  def list_book(location)
    get_url("/search.json?q=#{location}")
  end

  private
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.openlibrary.org')
  end
end