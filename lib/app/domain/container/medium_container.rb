# frozen_string_literal: true

require_relative "capacity"

class MediumContainer < Container
  def capacity
    Capacity.new(6)
  end

  def count(c)
    c.medium += 1
    c
  end
end
