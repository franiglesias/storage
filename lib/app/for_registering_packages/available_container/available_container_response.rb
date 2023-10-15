# frozen_string_literal: true

require_relative "../../domain/container/container"

class AvailableContainerResponse
  attr_reader :container

  def initialize(container)
    @container = container
  end
end
