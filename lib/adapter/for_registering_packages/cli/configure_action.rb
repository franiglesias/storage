# frozen_string_literal: true

require_relative "../../../app/for_managing_containers/configure/configure"
require_relative "../../../app/for_managing_containers/configure/containers_not_yet_configured"
require_relative "../../../app/for_managing_containers/configure/get_configuration"

class ConfigureAction
  def initialize(command_bus, query_bus, conf)
    @command_bus = command_bus
    @query_bus = query_bus
    @conf = conf
  end

  def execute
    @command_bus.execute(Configure.new(@conf))
  rescue ContainersNotYetConfigured
    puts "Configured storage:\n\nSystem is not configured"
  rescue AlreadyInstalled
    response = @query_bus.execute(GetConfiguration.new)
    puts <<~EOT
      Configured storage:

      System is already configured
      
      * Small:  #{response.small}
      * Medium: #{response.medium}
      * Large:  #{response.large}
    EOT
  else
    response = @query_bus.execute(GetConfiguration.new)
    puts <<~EOT
      Configured storage:
      
      * Small:  #{response.small}
      * Medium: #{response.medium}
      * Large:  #{response.large}
    EOT
  end
end
