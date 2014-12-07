require 'nokogiri'
require 'open-uri'

class EventGenerator
  def self.fetch
    doc = Nokogiri::HTML(open("http://www.theskint.com"))
    today = doc.css("article").first
    title = today.css("header .entry-title").text.strip
    main_content = today.css(".entry-content p")
    subtitle = main_content.first.css("u").text
    events = main_content.css("p").drop(1)

    events.map do |event|
      if event.css("a").present?
        { description: event.css("span").text,
          link: event.css("a").attr("href").value
        }
      end
    end
  end
end
