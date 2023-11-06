# frozen_string_literal: true

require_relative "get_configuration_response"

class GetConfigurationHandler
  def initialize(containers)
    @containers = containers
  end

  def handle(query)
    conf = @containers.configuration
    GetConfigurationResponse.new(
      conf.small,
      conf.medium,
      conf.large
    )
  end
end
