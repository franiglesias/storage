# frozen_string_literal: true

class PackageSize
  attr_reader :size
  def initialize(size)
    @size = size
  end

  def ==(other)
    @size == other.size
  end
end
