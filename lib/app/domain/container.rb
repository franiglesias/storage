# frozen_string_literal: true

class Container
  def initialize
    @packages = []
  end

  def contains?(locator)
    true
  end

  def available?
    true
  end

  def store(package)
    @packages.append(package)
  end
end

require_relative "full_container"
