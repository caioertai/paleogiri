require_relative 'book'
require_relative 'bookshelf'

BOOKSHELF = Bookshelf.new

# Tidies up the books
class Scribe
  def store(raw_shelf)
    File.open('test.csv', 'w') { |file| file << '' }
    raw_shelf.each do |book|
      raw_data = book.scan(/^\s*([\wÀ-ÿ].*?)\;?$/)
      new_book = Book.new(raw_data)
      BOOKSHELF.add_book(new_book)
      File.open('test.csv', 'a') { |file| file << "#{raw_data}\n" }
    end
  end

  # TODO
  # def strip_extra_space(string)
  # end

  # def trim_text(string)
  # end
end
