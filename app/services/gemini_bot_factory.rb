# frozen_string_literal: true

class GeminiBotFactory < BotFactory
  def create_bot
    GeminiBot.new(message)
  end
end
