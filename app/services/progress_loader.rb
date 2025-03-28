# frozen_string_literal: true

# Concrete Product classes
class ProgressLoader < Loader
  attr_reader :stream

  def initialize(stream)
    @stream = stream
  end

  def show
    Turbo::StreamsChannel.broadcast_update_to(
      stream,
      target: "loader",
      partial: "messages/loader"
    )
  end

  def hide
    Turbo::StreamsChannel.broadcast_update_to(
      stream,
      target: "loader",
      html: ""
    )
  end
end
