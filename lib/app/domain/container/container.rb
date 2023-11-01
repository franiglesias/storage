# frozen_string_literal: true

class Container
  def initialize(name)
    @name = name
    @packages = {}
  end

  def self.of_capacity(capacity, name)
    capacity_map = {
      small: SmallContainer.new(name),
      medium: MediumContainer.new(name),
      large: LargeContainer.new(name)
    }

    capacity_map[capacity.to_sym]
  end

  def contains?(locator)
    !@packages[locator].nil?
  end

  def capacity
    Capacity.new(4)
  end

  def has_space_for?(package = nil)
    remaining = capacity.subtract(allocated)
    return remaining.not_full? if package.nil?
    remaining.enough_for?(package)
  end

  def store(package)
    @packages[package.locator] = package
  end

  def is_named?(container_name)
    container_name == @name
  end

  private

  def allocated
    allocated = Capacity.new(0)
    @packages.each do |_, package|
      allocated = allocated.add_size(package)
    end
    allocated
  end

  public def to_s
    @name
  end
end

require_relative "full_container"
require_relative "small_container"
require_relative "medium_container"
require_relative "large_container"
