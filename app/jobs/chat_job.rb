class ChatJob < ApplicationJob
  queue_as :default

  def perform(chat_id, message)
    chat = Chat.find_by(id: chat_id)

    message_model = chat.messages.create!(query_string: message)

    Turbo::StreamsChannel.broadcast_append_to(
      "chat",
      target: "messages-container",
      partial: "messages/message",
      locals: { message: message_model }
    )

    # chat_llm = RubyLLM.chat(model: 'gemini-2.0-flash')
    # final_message = chat_llm.ask(message)
    #
    # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, underline: false, no_intra_emphasis: true)
    # message_model.update(content: markdown.render(final_message.content))

    # Turbo::StreamsChannel.broadcast_append_to(
    #   "chat",
    #   target: "message_#{message_model.id}_content",
    #   html: message_model.content
    # )

    sleep 3
    Turbo::StreamsChannel.broadcast_append_to(
      "chat",
      target: "message_#{message_model.id}_content",
      html: "chunk.content"
    )

    message_model.update(content: "chunk.content")

    # rescue RubyLLM::ServiceUnavailableError => e
    #   puts "\n ServiceUnavailableError: #{e.message}"
    # rescue RubyLLM::RateLimitError => e
    #   puts "\n RateLimitError: #{e.message}"
    # rescue RubyLLM::ServiceUnavailableError => e
    #   puts "\n BadRequestError: #{e.message}"
  end

end
