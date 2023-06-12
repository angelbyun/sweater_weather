require 'rails_helper'

RSpec.describe BookFacade do
  describe "instance methods" do
   describe "#get_book" do
    it "returns the first 5 books of 100 books from book search" do
      book = BookFacade.new.get_book("denver,co", "5")

      expect(book).to be_an(Hash)
    end
   end
  end
end