# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/app/domain/container"
require_relative "../../../../lib/app/domain/package/large_package"
require_relative "../../../../lib/app/for_registering_packages/available_container/available_container"
require_relative "../../../../lib/app/for_registering_packages/available_container/available_container_handler"
require_relative "../../../../lib/app/domain/available_containers"
require_relative "../../../../lib/adapter/for_managing_containers/memory/in_memory_containers"

RSpec.describe "AvailableContainerHandler" do
  context "when used for first time" do
    it "should provide available container" do
      package = LargePackage.new("locator")

      package_queue = double("PackageQueue")
      allow(package_queue).to receive(:get).and_return(package)
      allow(package_queue).to receive(:put)

      containers = InMemoryContainers.configure({
        small: 1
      })
      query = AvailableContainer.new
      handler = AvailableContainerHandler.new(containers, package_queue)
      response = handler.handle(query)

      expect(response.container).not_to be_nil
    end
  end
end
