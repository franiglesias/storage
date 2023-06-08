# frozen_string_literal: true

require_relative "../../lib/app/for_registering_packages/register_package/register_package"
require_relative "../../lib/app/for_registering_packages/register_package/register_package_handler"
require_relative "../../lib/app/for_registering_packages/available_container/available_container"
require_relative "../../lib/app/for_registering_packages/available_container/available_container_handler"

Given("Merry brings a package") do
  @register_package = RegisterPackage.new
end

When("package is registered") do
  register_package_handler = RegisterPackageHandler.new
  register_package_handler.handle(@register_package)
end

Then("it is assigned to a container") do
  what_container_is_assigned = AvailableContainer.new
  what_container_is_assigned_handler = AvailableContainerHandler.new
  response = what_container_is_assigned_handler.handle(what_container_is_assigned)
  expect(response.container).to be_truthy
end
