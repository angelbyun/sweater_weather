require 'rails_helper'

RSpec.describe BooksFacade do
  describe "instance methods" do
    before :each do
      @location = "denver,co"
      @quantity = 5
      @facade = BooksFacade.new(@location, @quantity)
    end

    describe "initialize" do
      it "exists" do
        expect(@facade).to be_a(BooksFacade)
      end
    end

    describe "#get_book" do
      it "returns a Book object" do
        expect(@facade.get_book).to be_a(Books)

        expect(@facade.get_book.destination).to eq(@location)

        expect(@facade.get_book.forecast).to be_a(Hash)
        expect(@facade.get_book.forecast).to have_key(:summary)
        expect(@facade.get_book.forecast[:summary]).to be_a(String)
        expect(@facade.get_book.forecast).to have_key(:temperature)
        expect(@facade.get_book.forecast[:temperature]).to be_a(Float)

        expect(@facade.get_book.total_books_found).to be_an(Integer)
        expect(@facade.get_book.total_books_found).to eq(758)

        expect(@facade.get_book.books).to be_an(Array)
        expect(@facade.get_book.books.count).to eq(@quantity)

        book_info = @facade.get_book.books.first

        expect(book_info).to be_a(Book)
        expect(book_info.isbn).to be_an(Array)
        expect(book_info.isbn).to eq(["0762507845", "9780762507849"])
        expect(book_info.publisher).to be_an(Array)
        expect(book_info.publisher).to eq(["Universal Map Enterprises"])
        expect(book_info.title).to be_a(String)
        expect(book_info.title).to eq("Denver, Co")
      end
    end
  end
end