# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/adapter/for_managing_containers/memory/in_memory_containers"
require_relative "../../../../lib/app/for_managing_containers/containers_spec"

RSpec.describe InMemoryContainers do
  context "implements interface" do
    it_behaves_like "a Containers"
  end
end
