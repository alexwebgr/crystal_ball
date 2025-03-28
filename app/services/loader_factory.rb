# frozen_string_literal: true

# Abstract Creator class
class LoaderFactory
  def create_loader
    raise NotImplementedError, "Subclasses must implement create_loader"
  end

  def perform_loading
    loader = create_loader
    loader.show
    yield if block_given?
    loader.hide
    loader
  end
end
