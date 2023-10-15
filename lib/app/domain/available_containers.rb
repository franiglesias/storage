# frozen_string_literal: true

class AvailableContainers
  def initialize(containers)
    @containers = containers
  end

  def self.empty
    AvailableContainers.new([])
  end

  def ==(other)
    @containers == other.list
  end

  def best_choice_for(package)
    @containers.each do |container|
      return container if container.has_space_for? package
    end
    nil
  end

  def list
    @containers
  end
end
