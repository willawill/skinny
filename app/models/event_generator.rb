require 'nokogiri'
require 'open-uri'

class EventGenerator
  def self.fetch
    doc = Nokogiri::HTML(open("http://www.theskint.com"))
    today = doc.css("article")[1]
    EventGenerator.new(today)
  end

  def as_json(options={})
    {
      date: title,
      subtitle: subtitle,
      event: events,
      free_events: free_events
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

  def free_events
    events.select {|item| item.is_free? }
  end

  def events
    main_content.css("p").drop(1).map do |event|
      Event.new(event)
    end
  end
end
