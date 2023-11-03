# frozen_string_literal: true

class ConfigureHandler
  def initialize(containers)
    @containers = containers
  end

  def handle(configure)
    raise ContainersNotYetConfigured.new
  end
end
