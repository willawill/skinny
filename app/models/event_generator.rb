require 'nokogiri'
require 'open-uri'

class EventGenerator
  def self.fetch
    doc = Nokogiri::HTML(open("http://www.theskint.com"))
    today = doc.css("article").first
    EventGenerator.new(today)
  end

  def as_json(options={})
    {
      date: title,
      subtitle: subtitle,
      events: events
    }
  end

  def initialize(data)
    @today = data
  end

  def title
    @today.css("header .entry-title").text.strip
  end

  def main_content
    @today.css(".entry-content p")
  end

  def subtitle
    main_content.first.css("u").text
  end

  def events
    main_content.css("p").drop(1).map { |event| Event.new(event) }
  end
end
