class FullContainer < Container
  def store(package)
    raise NoSpaceInContainer.new
  end

  def available?
    false
  end
end
