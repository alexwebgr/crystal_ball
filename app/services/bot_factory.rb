# frozen_string_literal: true

class BotFactory
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def create_bot
    raise NotImplementedError, "Subclasses must implement ask"
  end

  def ask
    bot = create_bot
    bot.render_answer
  end
end
