# frozen_string_literal: true

class InMemoryContainers
  def initialize
    @containers = []
  end

  def add(container)
    @containers.append(container)
  end

  def self.configure(conf)
    containers = InMemoryContainers.new
    conf.each do |size, qty|
      qty.times do
        containers.add(Container.of_capacity(size.to_sym))
      end
    end
    containers
  end

  def available
    tmp = []
    @containers.each do |container|
      tmp.append(container) if container.has_space_for?
    end
    tmp
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
