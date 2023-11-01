# frozen_string_literal: true

require_relative "../../lib/app/for_registering_packages/register_package/register_package"
require_relative "../../lib/app/for_registering_packages/register_package/register_package_handler"
require_relative "../../lib/app/for_registering_packages/available_container/available_container"
require_relative "../../lib/app/for_registering_packages/available_container/available_container_handler"
require_relative "../../lib/app/for_registering_packages/store_package/store_package"
require_relative "../../lib/app/for_registering_packages/store_package/store_package_handler"
require_relative "../../lib/adapter/for_enqueueing_packages/memory/in_memory_package_queue"
require_relative "../../lib/adapter/for_managing_containers/memory/in_memory_containers"
require_relative "../../lib/app/domain/container/container"
require_relative "../../lib/app/bus/command_bus"
require_relative "../../lib/app/bus/query_bus"
require_relative "../../lib/adapter/for_registering_packages/cli/action_factory"
require_relative "../../lib/adapter/for_registering_packages/cli/cli_adapter"
# There is space for allocating package

container_configuration = {
  small: 1,
  medium: 1,
  large: 1
}

def configure_storage_with(conf)
  queue = InMemoryPackageQueue.new
  containers = InMemoryContainers.configure(conf)

  command_bus = CommandBus.new(queue, containers)
  query_bus = QueryBus.new(queue, containers)

  factory = ActionFactory.new(command_bus, query_bus)

  CliAdapter.new(factory)
end

Given(/^there is enough capacity$/) do
  @storage = configure_storage_with(container_configuration)
end

When("Merry registers a package") do
  @output = capture_stdout { @storage.run(%w[register some-locator small]) }
end

Then("first available container is located") do
  @container_name = @output.split.last
  expect(@container_name).to eq("s-1")
end

Then("he puts the package into it") do
  output = capture_stdout { @storage.run(["store", @container_name]) }
  expect(output).to eq("package stored in container #{@container_name}\n")
end

# There is no enough space for allocating package

Given("no container with enough space") do
  @storage = configure_storage_with({})
end

Then("there is no available container") do
  expect(@output).to include("no space available")
end

Then("package stays in queue") do
  expect(@output).to include("Package some-locator is in waiting queue")
end

# Having a container with capacity
#
Given("an empty {string} container") do |capacity|
  configuration = {}
  configuration[capacity.to_sym] = 1
  @storage = configure_storage_with(configuration)
end

When("Merry registers a {string} size package") do |size|
  @output = capture_stdout { @storage.run(["register", "some-locator", size]) }
end

Then("package is allocated in container") do
  @container_name = @output.split.last
  expect(@container_name).to eq("s-1")
end

# Container with packages in it and not enough free space

Given("a {string} package stored") do |size|
  @storage.run(["register", "large-pkg", size])
end

def capture_stdout
  original = $stdout
  foo = StringIO.new
  $stdout = foo
  yield
  $stdout.string
ensure
  $stdout = original
end
