# frozen_string_literal: true

require_relative "capacity"

class LargeContainer < Container
  def capacity
    Capacity.new(8)
  end

  def count(c)
    c.large += 1
    c
  end
end
