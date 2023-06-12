require 'rails_helper'

RSpec.describe Book do
  it 'exists and has attributes' do
    book = BookFacade.new.get_book("denver,co", "5")

    expect(book).to be_a(Book)
  end
end