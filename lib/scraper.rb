require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.roster-cards-container").each do |roster|
      card.css(".student-card a").each do |student|
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
        profile_url =  "#{student.attr('href')}"
        
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

