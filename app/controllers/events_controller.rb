class EventsController < ApplicationController
  def index
    render json: EventGenerator.fetch
  end
end
