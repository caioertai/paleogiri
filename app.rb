require 'sqlite3'

# Instantiate a constant variable, DB, usable in all your files
dir = File.dirname(__FILE__)
DB = SQLite3::Database.new(File.join(dir, 'db/paleogiri.sqlite'))

# Require all the ruby files you have created in `app`
Dir[File.join(dir, 'app/**/*.rb')].each { |file| require file }

# Launch the app!
raw_data = ScrapService.new('http://purl.pt/index/geral/purl/PT/1-49.html').run
