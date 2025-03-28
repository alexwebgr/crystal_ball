# frozen_string_literal: true

# Concrete Creator classes
class ProgressLoaderFactory < LoaderFactory
  attr_reader :stream

  def initialize(stream)
    @stream = stream
  end

  def create_loader
    ProgressLoader.new(stream)
  end
end
