require_relative "../../../app/for_registering_packages/register_package/register_package"
require_relative "../../../app/for_registering_packages/available_container/available_container"

class RegisterPackageAction
  def initialize(command_bus, query_bus, locator, size)
    @command_bus = command_bus
    @query_bus = query_bus
    @locator = locator
    @size = size
  end

  def execute
    @command_bus.execute(RegisterPackage.new(@locator, @size))
    response = @query_bus.execute(AvailableContainer.new)
    "package #{@locator} to be stored in container #{response.container}"
  end
end
