# frozen_string_literal: true

class Capacity
  attr_reader :capacity
  def initialize(capacity)
    @capacity = capacity
  end

  def ==(other)
    @capacity == other.capacity
  end
end
