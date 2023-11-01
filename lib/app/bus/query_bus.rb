# frozen_string_literal: true

require_relative "../../adapter/for_enqueueing_packages/memory/in_memory_package_queue"
require_relative "../../adapter/for_managing_containers/memory/in_memory_containers"
require_relative "../../app/for_registering_packages/available_container/available_container_handler"

class QueryBus
  def initialize(queue, containers)
    @queue = queue
    @containers = containers
  end

  def execute(command)
    if command.instance_of?(AvailableContainer)
      AvailableContainerHandler.new(@containers, @queue).handle(command)
    end
  end
end
