# frozen_string_literal: true

require_relative "./available_container_response"

class AvailableContainerHandler
  def initialize(containers, queue)
    @containers = containers
    @queue = queue
  end

  def handle(available_container)
    package = @queue.get
    all_available = @containers.available
    best_choice = all_available.best_choice_for(package)
    if best_choice.nil?
      raise NoSpaceInContainer.new
    end
    @queue.put package
    AvailableContainerResponse.new(best_choice)
  end
end
