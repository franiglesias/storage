# frozen_string_literal: true

require "rspec"
require_relative "../../../../lib/app/for_registering_packages/store_package/store_package_handler"
require_relative "../../../../lib/app/for_registering_packages/store_package/store_package"
require_relative "../../../../lib/app/domain/container/container"
require_relative "../../../../lib/app/domain/package/package"

RSpec.describe StorePackageHandler do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context "Storing in container" do
    it "should store package in provided container" do
      package_queue = double("PackageQueue")
      containers = double("Containers")
      package = Package.new("locator")

      allow(package_queue).to receive(:get).and_return(package)
      expect(containers).to receive(:store) do |_, _|
      end

      handler = StorePackageHandler.new(package_queue, containers)
      command = StorePackage.new(Container.new("c"))

      handler.handle(command)
    end
  end
end
