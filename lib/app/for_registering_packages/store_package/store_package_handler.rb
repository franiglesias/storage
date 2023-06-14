# frozen_string_literal: true

class StorePackageHandler
  def initialize(package_queue, containers)
    @package_queue = package_queue
    @containers = containers
  end

  def handle(store_package)
    package = @package_queue.get
    container = store_package.container
    container.store(package)
    @containers.update(container)
  end
end
