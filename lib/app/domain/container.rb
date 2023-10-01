# frozen_string_literal: true

class Container
  def initialize
    @packages = []
  end

  def self.of_capacity(capacity)
    capacity_map = {
      small: SmallContainer.new,
      medium: MediumContainer.new,
      large: LargeContainer.new
    }

    capacity_map[capacity.to_sym]
  end

  def contains?(locator)
    true
  end

  def capacity
    Capacity.new(4)
  end

  def available?(package = nil)
    remaining = capacity.subtract(allocated)
    return remaining.not_full? if package.nil?
    remaining.enough_for?(package)
  end

  def store(package)
    @packages.append(package)
  end

  private

  def allocated
    alloc = Capacity.new(0)
    @packages.each do |package|
      alloc = alloc.add_size(package)
    end
    alloc
  end
end

require_relative "full_container"
require_relative "small_container"
require_relative "medium_container"
require_relative "large_container"
