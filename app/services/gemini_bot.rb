# frozen_string_literal: true

class GeminiBot < Bot
  BOT_NAME = "gemini-2.0-flash"

  def render_answer
    chat_llm = RubyLLM.chat(model: BOT_NAME)
    final_message = chat_llm.ask(message).content

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, underline: false, no_intra_emphasis: true)
    markdown.render(final_message)
  end
end
