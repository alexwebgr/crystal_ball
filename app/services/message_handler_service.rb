# frozen_string_literal: true

class MessageHandlerService
  attr_reader :chat
  attr_reader :message
  attr_reader :query_string

  def initialize(chat, query_string)
    @chat = chat
    @query_string = query_string
  end

  def create_message
    @message = chat.messages.create!(query_string: query_string)
    Turbo::StreamsChannel.broadcast_prepend_to(
      chat,
      target: "messages",
      partial: "messages/message",
      locals: { message: message }
    )
  end

  def update_message_label
    return if chat.label

    chat.update(label: message.query_string)
    Turbo::StreamsChannel.broadcast_update_to(
      chat,
      target: "chat_#{chat.id}_label",
      html: message.query_string
    )
  end

  def update_message_content
    # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, underline: false, no_intra_emphasis: true)
    #
    # message.update(content: markdown.render(ask_llm.content))

    sleep 4
    message.update(content: "markdown.render(ask_llm.content)")

    Turbo::StreamsChannel.broadcast_append_to(
      chat,
      target: "message_#{message.id}_content",
      html: message.content
    )
  end

  def ask_llm(model = 'gemini-2.0-flash')
    chat_llm = RubyLLM.chat(model: model)
    chat_llm.ask(message.query_string)
  end
end
