class ChatJob < ApplicationJob
  queue_as :default

  def perform(chat_id, message)
    chat = Chat.find_by(id: chat_id)

    message_model = chat.messages.create!(query_string: message)

    # chat_llm = RubyLLM.chat(model: 'gemini-2.0-flash')
    # final_message = chat_llm.ask(message)
    #
    # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, underline: false, no_intra_emphasis: true)
    # Turbo::StreamsChannel.broadcast_append_to(
    #   "chat_#{chat.id}",
    #   target: "chat_#{chat.id}",
    #   content: final_message[:content],
    #   append: true
    # )

    # message_model.update(content: markdown.render(final_message.content))
    message_model.update(content: "whatevs")

    # rescue RubyLLM::ServiceUnavailableError => e
    #   puts "\n ServiceUnavailableError: #{e.message}"
    # rescue RubyLLM::RateLimitError => e
    #   puts "\n RateLimitError: #{e.message}"
    # rescue RubyLLM::ServiceUnavailableError => e
    #   puts "\n BadRequestError: #{e.message}"
  end

end
