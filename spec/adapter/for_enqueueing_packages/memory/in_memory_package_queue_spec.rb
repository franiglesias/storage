# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/app/for_enqueueing_packages/package_queue_spec"

require_relative "../../../../lib/adapter/for_enqueueing_packages/memory/in_memory_package_queue"

RSpec.describe InMemoryPackageQueue do
  context "implements interface" do
    it_behaves_like "a PackageQueue"
  end
end
