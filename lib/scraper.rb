require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.roster-cards-container").each do |roster|
      card.css(".student-card a").each do |student|
        location = student.css(".student-location").text
        name = student.css(".student-name").text
        url =  "#{student.attr('href')}"
        student << {name: name
        
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

