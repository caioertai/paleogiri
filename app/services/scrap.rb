require 'open-uri'
require 'nokogiri'

# Runs through purl. TODO: convert it into a service object
class ScrapService
  def initialize(url)
    @raw_shelf = []
    @url = url
  end

  def run
    while @url && prepare_next_run
      begin
        doc = Nokogiri::HTML(open(@url))
        collect_data(doc)
      rescue StandardError => e
        puts "Couldn't read \"#{url}\": #{e}"
        @url = false
      end
    end
    p @raw_shelf
  end

  private

  def prepare_next_run
    position = @url.match(/(\d*)-(\d*)/)
    new_min = position[1] == '1' ? 50 : position[1].to_i + 50
    new_max = position[2].to_i + 50
    new_position = "#{new_min}-#{new_max}"
    @url = @url.gsub(/\d*-\d*/, new_position)
  end

  def collect_data(doc)
    doc.search('.coverCell').each do |e|
      cover = e.parent
      @raw_shelf << "#{cover.text}
                     #{cover.next_element.text}
                     #{cover.next_element.next_element.text}
                     #{cover.next_element.next_element.next_element.text}"
    end
  end
end
