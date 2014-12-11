class Event
  def initialize(event)
    @content = event
  end

  def as_json(options={})
    {
      description: description,
      event_link: event_link
    }
  end

  def description
    @content.css("span").text
  end

  def event_link
    @content.css("a").present? ? @content.css("a").attr("href").value : ""
  end

  def is_free?
    !!description["free"]
  end
end
