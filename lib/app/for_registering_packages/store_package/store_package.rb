# frozen_string_literal: true

class StorePackage
  attr_reader :container
  def initialize(container)
    @container = container
  end
end
