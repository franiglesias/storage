# frozen_string_literal: true

class Package
  attr_reader :locator
  def initialize(locator)
    @locator = locator
  end

  def self.register(locator, size)
    return SmallPackage.new(locator) if size == "small"
    return LargePackage.new(locator) if size == "large"
  end

  def allocated?
    false
  end

  def size
    PackageSize.new(1)
  end
end

require_relative "small_package"
require_relative "large_package"
