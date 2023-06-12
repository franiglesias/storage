# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/app/domain/container"
require_relative "../../../../lib/app/for_registering_packages/available_container/available_container"
require_relative "../../../../lib/app/for_registering_packages/available_container/available_container_handler"

RSpec.describe "AvailableContainerHandler" do
  context "when used for first time" do
    it "should provide available container" do
      containers = double("Containers")
      expected = Container.new
      allow(containers).to receive(:available).and_return(expected)
      query = AvailableContainer
      handler = AvailableContainerHandler.new(containers)
      response = handler.handle(query)
      container = response.container

      expect(container).to eq(expected)
    end
  end
end
