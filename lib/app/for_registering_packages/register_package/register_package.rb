# frozen_string_literal: true

class RegisterPackage
  attr_reader :locator
  def initialize(locator)
    @locator = locator
  end
end
