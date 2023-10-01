# frozen_string_literal: true

require_relative "capacity"

class MediumContainer < Container
  def capacity
    Capacity.new(6)
  end
end
