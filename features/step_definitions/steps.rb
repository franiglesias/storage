# frozen_string_literal: true

Given('Merry brings a package') do
  @register_package = RegisterPackage.new()
end

When('package is registered') do
  register_package_handler = RegisterPackageHandler.new
  register_package_handler.handle(@register_package)
end

Then('it is assigned to a container') do
  what_container_is_assigned = WhatContainerIsAvailable.new
  what_container_is_assigned_handler = WhatContainerIsAvailableHandler.new
  response = what_container_is_assigned_handler.handle(what_container_is_assigned)
  expect(response.package_was_assigned).to be_truthy
end
