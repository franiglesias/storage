# frozen_string_literal: true

require_relative "../../domain/container"

class AvailableContainerResponse
  def container
    Container.new
  end
end
