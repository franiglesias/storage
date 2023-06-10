class InMemoryPackageQueue
  def initialize
    @packages = []
  end

  def put(package)
    @packages.unshift(package)
  end

  def include?(package)
    @packages.include?(package)
  end
end
