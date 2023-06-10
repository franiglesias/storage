# frozen_string_literal: true

require "rspec"

require_relative "../../../app/for_enqueueing_packages/package_queue_spec"

require_relative "../../../../lib/adapter/for_enqueueing_packages/memory/in_memory_package_queue"

RSpec.describe InMemoryPackageQueue do
  context "honors interface" do
    it_behaves_like "a PackageQueue"
  end
end
