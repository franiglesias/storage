# frozen_string_literal: true

class StorePackageHandler
  def initialize(package_queue, containers)
    @package_queue = package_queue
    @containers = containers
  end

  def handle(store_package)
    package = @package_queue.get
    @containers.store(store_package.container, package)
  end
end
