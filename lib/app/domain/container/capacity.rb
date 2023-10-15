# frozen_string_literal: true

Capacity = Struct.new(:capacity)
class Capacity
  def >(other)
    capacity > other.capacity
  end

  def subtract(other)
    remaining = capacity - other.capacity
    Capacity.new(remaining)
  end

  def enough_for?(package)
    capacity >= package.size.size
  end

  def not_full?
    capacity > 0
  end

  def add(other)
    size = capacity + other.capacity
    Capacity.new(size)
  end

  def add_size(package)
    Capacity.new(capacity + package.size.size)
  end
end
