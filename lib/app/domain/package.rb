# frozen_string_literal: true

class Package
  def initialize(locator)
    @locator = locator
  end

  def self.register(locator)
    Package.new(locator)
  end

  def allocated?
    false
  end
end
