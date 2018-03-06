require 'open-uri'
require 'nokogiri'

# Runs through purl. TODO: convert it into a service object
class Scrapper
  def initialize(url)
    @raw_shelf = []
    @url = url
  end

  def run
    1.times do
      collect_data(@url)
      prepare_next_run
    end
    @raw_shelf
  end

  private

  def prepare_next_run
    position = @url.match(/(\d*)-(\d*)/)
    new_min = position[1] == '1' ? 50 : position[1].to_i + 50
    new_max = position[2].to_i + 50
    new_position = "#{new_min}-#{new_max}"
    @url = @url.gsub(/\d*-\d*/, new_position)
  end

  def collect_data(url)
    Nokogiri::HTML(open(url).read).search('.coverCell').each do |e|
      raw_book = '' + e.parent.text
      raw_book += e.parent.next.next.text
      raw_book += e.parent.next.next.next.next.text
      raw_book += e.parent.next.next.next.next.next.next.text
      @raw_shelf << raw_book
    end
  end
end
