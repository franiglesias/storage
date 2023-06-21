# frozen_string_literal: true

require_relative "./available_container_response"

class AvailableContainerHandler
  def initialize(containers, queue)
    @containers = containers
    @queue = queue
  end

  def handle(available_container)
    package = @queue.get
    available = @containers.available package
    @queue.put package
    AvailableContainerResponse.new(available)
  end
end
