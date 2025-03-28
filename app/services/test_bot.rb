# frozen_string_literal: true

class TestBot < Bot
  BOT_NAME = "test"

  def render_answer
    # sleep 5
    md = <<-MARKDOWN
MARKDOWN

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, underline: false, no_intra_emphasis: true)
    markdown.render(md)
  end
end
