require_relative "no_action"
require_relative "register_package_action"

class ActionFactory
  def initialize(command_bus, query_bus)
    @command_bus = command_bus
    @query_bus = query_bus
  end

  def for_subcommand(args)
    sub_command = args[0]
    case sub_command
    when "register"
      locator = args[1]
      size = args[2]
      RegisterPackageAction.new(@command_bus, @query_bus, locator, size)
    else
      NoAction.new
    end
  end
end
