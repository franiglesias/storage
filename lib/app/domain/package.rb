# frozen_string_literal: true

class Package
  attr_reader :locator
  def initialize(locator)
    @locator = locator
  end

  def self.register(locator, size)
    return SmallPackage.new(locator) if size == "small"
  end

  def allocated?
    false
  end

  def size
    PackageSize.new("small")
  end
end

class SmallPackage < Package
  def size
    PackageSize.new("small")
  end
end
