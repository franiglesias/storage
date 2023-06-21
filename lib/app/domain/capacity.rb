# frozen_string_literal: true

class Capacity
  attr_reader :capacity
  def initialize(capacity)
    @capacity = capacity
  end

  def ==(other)
    @capacity == other.capacity
  end

  def subtract(other)
    remaining = @capacity - other.capacity
    Capacity.new(remaining)
  end

  def enough_for?(package)
    @capacity >= package.size.size
  end

  def not_full?
    @capacity > 0
  end

  def add_size(package)
    Capacity.new(@capacity + package.size.size)
  end
end
