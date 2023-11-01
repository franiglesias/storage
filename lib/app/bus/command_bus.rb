# frozen_string_literal: true

require_relative "../../adapter/for_enqueueing_packages/memory/in_memory_package_queue"
require_relative "../../app/for_registering_packages/register_package/register_package_handler"

class CommandBus
  def initialize(queue, containers)
    @queue = queue
    @containers = containers
  end

  def execute(command)
    if command.instance_of?(RegisterPackage)
      RegisterPackageHandler.new(@queue).handle(command)
    end
    if command.instance_of?(StorePackage)
      StorePackageHandler.new(@queue, @containers).handle(command)
    end
  end
end
