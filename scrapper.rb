require 'open-uri'
require 'nokogiri'

class Scrapper
  def initialize(url)
    @raw_shelf = []
    @url = url
  end

  def run
    10.times do
      collect_data(@url)
      prepare_next_run
    end
    @raw_shelf
  end

  private

  def prepare_next_run
    position = @url.match(/(\d*)-(\d*)/)
    new_min = position[1] == "1" ? 50 : position[1].to_i + 50
    new_max = position[2].to_i + 50
    new_position = "#{new_min}-#{new_max}"
    @url = @url.gsub(/\d*-\d*/, new_position)
    p @url
  end

  def collect_data(url)
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)

    doc.search('.coverCell').each do |e|
      f_row = e.parent

      first_row = e.parent.text
      second_row = e.parent.next.next.text
      third_row = e.parent.next.next.next.next.text
      fourth_row = e.parent.next.next.next.next.next.next.text

      raw_book = first_row + second_row + third_row + fourth_row
      @raw_shelf << raw_book
    end
  end
end