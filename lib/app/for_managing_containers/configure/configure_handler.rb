# frozen_string_literal: true

class ConfigureHandler
  def initialize(containers)
    @containers = containers
  end

  def handle(configure)
    if (configure.conf == {}) && !@containers.configured?
      raise ContainersNotYetConfigured.new
    end
    @containers.reconfigure(configure.conf)
  end
end
