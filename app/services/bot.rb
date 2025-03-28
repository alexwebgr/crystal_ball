# frozen_string_literal: true

class Bot
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def render_answer
    raise NotImplementedError, "Subclasses must implement render_answer"
  end
end
