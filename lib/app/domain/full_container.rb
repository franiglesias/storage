class FullContainer < Container
  def store(package)
    raise NoSpaceInContainer.new
  end

  def available?(package = nil)
    false
  end
end
