class ChatJob < ApplicationJob
  queue_as :default

  def perform(chat_id, message)
    chat = Chat.find_by(id: chat_id)
    message_handler = MessageHandlerService.new(chat, message)
    message_handler.create_message
    message_handler.update_message_label

    progress_loader = ProgressLoaderFactory.new(chat)
    progress_loader.perform_loading do
      message_handler.update_message_content
    end

  rescue RubyLLM::ServiceUnavailableError,
         RubyLLM::RateLimitError,
         RubyLLM::BadRequestError,
         StandardError => e
    Turbo::StreamsChannel.broadcast_append_to(
      chat,
      target: "toast-container",
      partial: "messages/toast",
      locals: {
        message: e.message,
        type: "danger"
      }
    )
    progress_loader&.create_loader&.hide
  end
end
