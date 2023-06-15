# frozen_string_literal: true

class InMemoryContainers
  def initialize
    @container = Container.new
  end

  def available
    @container
  end

  def update(container)
    @container = container
  end
end
