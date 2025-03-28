# frozen_string_literal: true

# Abstract Product interface
class Loader
  def show
    raise NotImplementedError, "Subclasses must implement show"
  end

  def hide
    raise NotImplementedError, "Subclasses must implement hide"
  end
end
