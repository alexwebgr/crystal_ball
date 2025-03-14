RubyLLM.configure do |config|
  # Add the API keys you have available
  config.openai_api_key = Rails.application.credentials.openai_api_key
  # config.anthropic_api_key = ENV['ANTHROPIC_API_KEY']
  config.gemini_api_key = Rails.application.credentials.gemini_api_key
  # config.deepseek_api_key = ENV['DEEPSEEK_API_KEY']
end
