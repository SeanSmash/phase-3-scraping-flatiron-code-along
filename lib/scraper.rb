require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    doc = Nokogiri::HTML(URI.open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    
  end

  def get_courses 
    self.get_page.css('.post')
  end

  def make_courses
    self.get_courses.css(".post").each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end
  
end

Scraper.new.get_page
Scraper.new.print_courses

#doc.css('.post').first.css('h2').text
#doc.css('.post').first.css('.date').text
#doc.css('.post').first.css('p').text

