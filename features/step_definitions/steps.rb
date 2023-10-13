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
  register_package = RegisterPackage.new @locator, "small"
  register_package_handler = RegisterPackageHandler.new @memory_package_queue
  register_package_handler.handle(register_package)
end

Then("first available container is located") do
  @containers = InMemoryContainers.configure({
    small: 1,
    medium: 1,
    large: 1
  })
  available_container = AvailableContainer.new
  available_container_handler = AvailableContainerHandler.new(@containers, @memory_package_queue)
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
end

Then("there is no available container") do
  available_container = AvailableContainer.new
  available_container_handler = AvailableContainerHandler.new(@containers, @memory_package_queue)
  response = available_container_handler.handle(available_container)
  @container = response.container
  expect(@container).to be_nil
end

Then("package stays in queue") do
  recovered = @memory_package_queue.get
  expect(recovered.locator).to eq(@locator)
end

# Having a container with capacity
#
Given("an empty {string} container") do |capacity|
  @containers = InMemoryContainers.new
  @small_container = Container.of_capacity(capacity)
  @containers.add(@small_container)
end

When("Merry registers a {string} size package") do |size|
  @memory_package_queue = InMemoryPackageQueue.new
  @locator = "some-locator"
  register_package = RegisterPackage.new(@locator, size)
  register_package_handler = RegisterPackageHandler.new @memory_package_queue
  register_package_handler.handle(register_package)
end

Then("package is allocated in container") do
  available_container = AvailableContainer.new
  available_container_handler = AvailableContainerHandler.new(@containers, @memory_package_queue)
  response = available_container_handler.handle(available_container)
  @container = response.container
  expect(@container).to be(@small_container)
end

# Container with packages in it and not enough free space

Given("a {string} package stored") do |size|
  package = Package.register("large-pkg", size)
  @small_container.store(package)
  @containers.update(@small_container)
end
