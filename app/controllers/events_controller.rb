class EventsController < ApplicationController
  def index
    @doc = EventGenerator.fetch
    render json: @doc
  end
end
