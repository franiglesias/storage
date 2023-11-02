# frozen_string_literal: true

require_relative "../../../app/for_registering_packages/store_package/store_package"
require_relative "../../../app/for_registering_packages/store_package/store_package_handler"
require_relative "../../../app/domain/container/no_space_in_container"

class StorePackageAction
  def initialize(command_bus, container_name)
    @command_bus = command_bus
    @container_name = container_name
  end

  def execute
    @command_bus.execute(StorePackage.new(@container_name))
  rescue NoSpaceInContainer
    "no space available. package is in waiting queue"
  else
    "package stored in container #{@container_name}"
  end
end
