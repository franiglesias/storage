# frozen_string_literal: true

class RegisterPackage
  attr_reader :locator, :size
  def initialize(locator, size)
    @locator = locator
    @size = size
  end
end
