require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card a")
    students.collect do |student|
      {
        :name => student.css(".student-name").text ,
        :location => student.css(".student-location").text,
        :profile_url => student.attr('href')
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    students = {}
    profiles = Nokogiri::HTML(open(profile_url))
    
    profiles.css("div.main-wrapper.profile .social-icon-container a").each do |social| 
      social.each do |element| 
        if element.attr('href').include?("twitter")
          students[:twitter] = element.attr('href')
        elsif element.attr('href').include?("linkedin")
          students[:linkedin] = element.attr('href')
        elsif element.attr('href').include?("github")
          students[:github] = element.attr('href')
        elsif element.attr('href').end_with?("com/")
          students[:blog] = element.attr('href')
        end
      end
      students[:profile_quote] = profiles.css(".vitals-container .vitals-text-container .profile-quote").text
      students[:bio] = profiles.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
    end
    students
  end
end

