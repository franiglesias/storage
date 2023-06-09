# frozen_string_literal: true

require_relative "../../lib/app/for_registering_packages/register_package/register_package"
require_relative "../../lib/app/for_registering_packages/register_package/register_package_handler"
require_relative "../../lib/app/for_registering_packages/available_container/available_container"
require_relative "../../lib/app/for_registering_packages/available_container/available_container_handler"
require_relative "../../lib/app/for_registering_packages/store_package/store_package"
require_relative "../../lib/app/for_registering_packages/store_package/store_package_handler"

Given("Merry registers a package") do
  @locator = "some-locator"
  register_package = RegisterPackage.new @locator
  register_package_handler = RegisterPackageHandler.new
  register_package_handler.handle(register_package)
end

Then("first available container is located") do
  available_container = AvailableContainer.new
  available_container_handler = AvailableContainerHandler.new
  response = available_container_handler.handle(available_container)
  @container = response.container
end

Then("he puts the package into it") do
  store_package = StorePackage.new(@container)
  store_package_handler = StorePackageHandler.new
  store_package_handler.handle(store_package)

  expect(@container.contains?(@locator)).to be_truthy
end
