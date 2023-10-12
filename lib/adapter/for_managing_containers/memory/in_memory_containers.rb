# frozen_string_literal: true

class InMemoryContainers
  def initialize
    @container = Container.new
  end

  def available(package)
    return @container if @container.has_space_for?(package)
    nil
  end

  def update(container)
    @container = container
  end
end
