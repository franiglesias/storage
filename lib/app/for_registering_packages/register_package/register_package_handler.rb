# frozen_string_literal: true

require_relative "../../../app/domain/package"

class RegisterPackageHandler
  def initialize(package_queue)
    @package_queue = package_queue
  end

  def handle(register_package)
    package = Package.register(register_package.locator, register_package.size)
    @package_queue.put(package)
  end
end
