# frozen_string_literal: true

class Container
  def initialize
    @packages = []
  end

  def self.of_capacity(capacity)
    return SmallContainer.new if capacity == "small"
  end

  def contains?(locator)
    true
  end

  def capacity
    Capacity.new(4)
  end

  def available?
    true
  end

  def store(package)
    @packages.append(package)
  end
end

require_relative "full_container"
require_relative "small_container"
