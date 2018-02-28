require 'open-uri'
require 'nokogiri'

def purl_scrapper
  # TODO: return an array of Antiques found of Craiglist for this `city`.
  html_content = open("http://purl.pt/index/geral/aut/PT/39569.html").read
  doc = Nokogiri::HTML(html_content)

  results = []


  author = doc.search('.indexTitle').text.strip.gsub('Obras digitalizadas de ', '')

  puts "======================="
  doc.search('.coverCell').each do |e|
    puts 'Title   ' + e.parent.css('.workInfo a').attr('title').text.strip.gsub(/^\W+|\W+$/, '')
    puts 'Link    ' + e.parent.css('.workInfo a').attr('href').text
    puts 'Author  ' + author
    # puts 'Author  ' + e.parent.next_element.css('.workSubInfo span').text.strip
    puts 'When    ' + e.parent.next_element.css('.workSubInfo a').text.strip
    puts 'When    ' + e.parent.next_element.next_element.css('.workSubInfo').text.strip
    puts 'Link    ' + e.parent.next_element.next_element.next_element.css('.workSubInfo').text.strip
    puts "==========================================================="
  end
end

purl_scrapper
