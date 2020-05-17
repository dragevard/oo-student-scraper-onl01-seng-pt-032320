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
    
    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
       if social.attribute("href").value.include?("twitter")
         students[:twitter] = social.attribute("href").value
       elsif social.attribute("href").value.include?("linkedin")
         students[:linkedin] = social.attribute("href").value
       elsif social.attribute("href").value.include?("github")
         students[:github] = social.attribute("href").value
       else
         students[:blog] = social.attribute("href").value
       end
      students[:profile_quote] = profiles.css(".vitals-container .vitals-text-container .profile-quote").text
      students[:bio] = profiles.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
    end
    students
  end
end

