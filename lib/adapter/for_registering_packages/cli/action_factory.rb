require_relative "no_action"
require_relative "register_package_action"
require_relative "store_package_action"
require_relative "configure_action"
require_relative "option_parser"

class ActionFactory
  def initialize(command_bus, query_bus)
    @command_bus = command_bus
    @query_bus = query_bus
  end

  def for_subcommand(args)
    parser = OptionParser.new(args)
    sub_command = args[0]
    case sub_command
    when "register"
      locator = args[1]
      size = args[2]
      RegisterPackageAction.new(@command_bus, @query_bus, locator, size)
    when "store"
      container = args[1]
      StorePackageAction.new(@command_bus, container)
    when "configure"
      conf = {}
      small = parser.by_name_or_default("small", 0).to_i
      medium = parser.by_name_or_default("medium", 0).to_i
      large = parser.by_name_or_default("large", 0).to_i
      conf[:small] = small unless small == 0
      conf[:medium] = medium unless medium == 0
      conf[:large] = large unless large == 0
      ConfigureAction.new(@command_bus, @query_bus, conf)
    else
      NoAction.new
    end
  end
end
