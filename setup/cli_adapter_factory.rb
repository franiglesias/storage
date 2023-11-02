require_relative "../lib/adapter/for_enqueueing_packages/memory/in_memory_package_queue"
require_relative "../lib/adapter/for_managing_containers/memory/in_memory_containers"
require_relative "../lib/app/domain/container/container"
require_relative "../lib/app/bus/command_bus"
require_relative "../lib/app/bus/query_bus"
require_relative "../lib/adapter/for_registering_packages/cli/action_factory"
require_relative "../lib/adapter/for_registering_packages/cli/cli_adapter"

class CliAdapterFactory
  def self.for_test(conf)
    queue = InMemoryPackageQueue.new
    containers = InMemoryContainers.configure(conf)
    command_bus = CommandBus.new(queue, containers)
    query_bus = QueryBus.new(queue, containers)
    factory = ActionFactory.new(command_bus, query_bus)
    CliAdapter.new(factory)
  end
end
