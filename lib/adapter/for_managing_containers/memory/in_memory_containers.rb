# frozen_string_literal: true

class InMemoryContainers
  def initialize
    @container = Container.new
  end

  def available(package)
    return @container if @container.available?(package)
    nil
  end

  def update(container)
    @container = container
  end
end
