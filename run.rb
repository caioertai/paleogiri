require_relative 'scrapper'
require_relative 'scribe'

scrapper = Scrapper.new("http://purl.pt/index/geral/purl/PT/1-49.html")
raw_shelf = scrapper.run

scribe = Scribe.new
scribe.store(raw_shelf)

# BOOKSHELF.show_all