class FullContainer < Container
  def store(package)
    raise NoSpaceInContainer.new
  end

  def has_space_for?(package = nil)
    false
  end
end
