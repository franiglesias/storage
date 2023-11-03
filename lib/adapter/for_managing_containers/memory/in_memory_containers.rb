# frozen_string_literal: true

require_relative "../../../app/domain/available_containers"
require_relative "../../../app/domain/container/no_space_in_container"
class InMemoryContainers
  def initialize
    @containers = []
  end

  def configured?
    @containers == []
  end

  def add(container)
    @containers.append(container)
  end

  def self.configure(conf)
    containers = InMemoryContainers.new
    conf.each do |size, qty|
      qty.times do |index|
        name = "#{size[0]}-#{index + 1}"
        containers.add(Container.of_capacity(size.to_sym, name))
      end
    end
    containers
  end

  def store(container_name, package)
    @containers.each do |container|
      if container.is_named?(container_name)
        if container.has_space_for?(package)
          return container.store(package)
        end
      end
    end
    raise NoSpaceInContainer.new
  end

  def available
    tmp = []
    @containers.each do |container|
      tmp.append(container) if container.has_space_for?
    end
    AvailableContainers.new(tmp)
  end

  def update(container)
    add(container)
  end

  def available_space?
    total_space > Capacity.new(0)
  end

  def total_space
    capacity = Capacity.new(0)
    @containers.each do |container|
      capacity = capacity.add(container.capacity)
    end
    capacity
  end
end
