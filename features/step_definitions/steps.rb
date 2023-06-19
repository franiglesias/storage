# frozen_string_literal: true

require_relative "../../lib/app/for_registering_packages/register_package/register_package"
require_relative "../../lib/app/for_registering_packages/register_package/register_package_handler"
require_relative "../../lib/app/for_registering_packages/available_container/available_container"
require_relative "../../lib/app/for_registering_packages/available_container/available_container_handler"
require_relative "../../lib/app/for_registering_packages/store_package/store_package"
require_relative "../../lib/app/for_registering_packages/store_package/store_package_handler"
require_relative "../../lib/adapter/for_enqueueing_packages/memory/in_memory_package_queue"
require_relative "../../lib/adapter/for_managing_containers/memory/in_memory_containers"
require_relative "../../lib/app/domain/container"

# There is space for allocating package

Given("Merry registers a package") do
  @memory_package_queue = InMemoryPackageQueue.new
  @locator = "some-locator"
  register_package = RegisterPackage.new @locator
  register_package_handler = RegisterPackageHandler.new @memory_package_queue
  register_package_handler.handle(register_package)
end

Then("first available container is located") do
  @containers = InMemoryContainers.new
  available_container = AvailableContainer.new
  available_container_handler = AvailableContainerHandler.new(@containers)
  response = available_container_handler.handle(available_container)
  @container = response.container
end

Then("he puts the package into it") do
  store_package = StorePackage.new(@container)
  store_package_handler = StorePackageHandler.new(@memory_package_queue, @containers)
  store_package_handler.handle(store_package)

  expect(@container.contains?(@locator)).to be_truthy
end

# There is no enough space for allocating package

Given("no container with enough space") do
  @containers = InMemoryContainers.new
  full_container = FullContainer.new
  @containers.update(full_container)

  available_container = AvailableContainer.new
  available_container_handler = AvailableContainerHandler.new(@containers)
  response = available_container_handler.handle(available_container)
  @container = response.container
  expect(@container).to be_nil
end

Then("package stays in queue") do
  recovered = @memory_package_queue.get
  expect(recovered.locator).to eq(@locator)
end
