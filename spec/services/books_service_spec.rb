require 'rails_helper'

RSpec.describe BooksService do
  describe "#list_book" do
    # it "returns a list of books based upon a specific search" do
    #   book_service = BooksService.new.list_book("denver,co")

    #   expect(book_service).to be_a(Hash)
    #   expect(book_service[:docs]).to be_an(Array)
    #   expect(book_service[:numFound]).to eq(758)

    #   book_data = book_service[:docs].first

    #   expect(book_data).to be_a(Hash)
    #   expect(book_data).to have_key(:isbn)
    #   expect(book_data[:isbn]).to eq(["0762507845", "9780762507849"])
    #   expect(book_data).to have_key(:title)
    #   expect(book_data[:title]).to eq("Denver, Co")
    #   expect(book_data).to have_key(:publisher)
    #   expect(book_data[:publisher]).to eq(["Universal Map Enterprises"])
    # end
  end
end