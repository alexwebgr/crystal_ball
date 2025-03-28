# frozen_string_literal: true

class TestBotFactory < BotFactory
  def create_bot
    TestBot.new(message)
  end
end
