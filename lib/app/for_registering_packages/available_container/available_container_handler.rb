# frozen_string_literal: true

require_relative "./available_container_response"

class AvailableContainerHandler
  def initialize(containers)
    @containers = containers
  end

  def handle(available_container)
    available = @containers.available
    AvailableContainerResponse.new(available)
  end
end
