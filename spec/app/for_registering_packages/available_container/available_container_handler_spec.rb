# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/app/domain/container"
require_relative "../../../../lib/app/for_registering_packages/available_container/available_container"
require_relative "../../../../lib/app/for_registering_packages/available_container/available_container_handler"

RSpec.describe "AvailableContainerHandler" do
  context "when used for first time" do
    it "should provide available container" do
      containers = double("Containers")
      package_queue = double("PackageQueue")
      expected = Container.new
      allow(containers).to receive(:available).and_return(expected)
      allow(package_queue).to receive(:get).and_return(LargePackage.new("locator"))
      allow(package_queue).to receive(:put)
      query = AvailableContainer
      handler = AvailableContainerHandler.new(containers, package_queue)
      response = handler.handle(query)
      container = response.container

      expect(container).to eq(expected)
    end
  end
end
