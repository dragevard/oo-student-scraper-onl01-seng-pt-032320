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
        student_url =  "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students = {}
    profiles = Nokogiri::HTML(open(profile_url))
    
    profiles.css("div.social-icon-container").each do |social| 
      if social.attribute("href").value.include?("twitter")
         students[:twitter] = social.attribute("href").value
       elsif social.attribute("href").value.include?("linkedin")
         students[:linkedin] = social.attribute("href").value
       elsif social.attribute("href").value.include?("github")
         students[:github] = social.attribute("href").value
       else
         students[:blog] = social.attribute("href").value
       end
     end
      students[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      students[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
    end
    students
  end
end

