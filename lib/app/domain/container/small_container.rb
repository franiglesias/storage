# frozen_string_literal: true

require_relative "capacity"

class SmallContainer < Container
  def capacity
    Capacity.new(4)
  end

  def count(c)
    c.small += 1
    c
  end
end
