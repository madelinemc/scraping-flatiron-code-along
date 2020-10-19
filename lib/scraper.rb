require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page #responsbile for using Nokogiri and open-uri to grab the entire HTML document from the web page

    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

    # def get_page ALL IN ONE SCRAPER that was split into get_courses and make_courses:
    # doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

    # doc.css(".post").each do |post| #for each iteration over the collection of Nokogiri XML elements returned to us by the doc.css(".post") line we are making a new instance of the Course class
    #   course = Course.new
    #   course.title = post.css("h2").text #and giving that instance title, schedule, and description extracted from the XML
    #   course.schedule = post.css(".date").text
    #   course.description = post.css("p").text
    # end
  end

# Scraper.new.get_page

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses #responsible for instantiating Course objects and giving each course object the correct title, schedule, and description attitude scraped from the page
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end
  
  def print_courses #calls on make_courses and iterates over all of the courses that get created to puts out a list of the course offerings.
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.print_courses

