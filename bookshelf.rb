# Storage class
class Bookshelf
  attr_reader :bookshelf
  def initialize(bookshelf = [])
    @bookshelf = bookshelf
  end

  def add_book(book)
    @bookshelf << book
  end

  def show_all
    @bookshelf.each { |book| puts book.raw_data }
  end
end
