require_relative "../../for_managing_containers/../../app/for_enqueueing_packages/no_more_packages"

class InMemoryPackageQueue
  def initialize
    @packages = []
  end

  def put(package)
    @packages.unshift(package)
  end

  def get
    if @packages.length < 1
      raise NoMorePackages
    end
    @packages.pop
  end

  def include?(package)
    @packages.include?(package)
  end
end
