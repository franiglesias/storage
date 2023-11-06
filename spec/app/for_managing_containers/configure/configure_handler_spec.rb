# frozen_string_literal: true

require "rspec"
require_relative "../../../../lib/app/for_managing_containers/configure/configure_handler"
require_relative "../../../../lib/app/for_managing_containers/configure/configure"
require_relative "../../../../lib/adapter/for_managing_containers/memory/in_memory_containers"
require_relative "../../../../lib/app/domain/container/capacity"

RSpec.describe "ConfigureHandler" do
  context "Containers not configured" do
    it "should install with passed configuration" do
      containers = InMemoryContainers.configure({})
      handler = ConfigureHandler.new(containers)
      handler.handle(Configure.new({small: 3}))
      expect(containers.total_space).to eq(Capacity.new(12))
    end
  end
end
