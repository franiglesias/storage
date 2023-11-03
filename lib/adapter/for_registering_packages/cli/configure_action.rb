# frozen_string_literal: true

require_relative "../../../app/for_managing_containers/configure/configure"
require_relative "../../../app/for_managing_containers/configure/containers_not_yet_configured"

class ConfigureAction
  def initialize(command_bus, conf)
    @command_bus = command_bus
    @conf = conf
  end

  def execute
    @command_bus.execute(Configure.new(@conf))
  rescue ContainersNotYetConfigured
    puts "Configured storage:\n\nSystem is not configured"
  else
    puts "Should do something about configuration success"
  end
end
