# frozen_string_literal: true

require "rspec"

require_relative "../../../lib/app/domain/container"
require_relative "../../../lib/app/domain/package"
require_relative "../../../lib/app/domain/no_space_in_container"

RSpec.describe "Container" do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context "Container instantiation" do
    it "should prepare container of desired capacity" do
      small = Container.of_capacity("small")
      expect(small.capacity).to eq(Capacity.new(4))
    end
  end

  context "Space available" do
    it "should be available if empty" do
      expect(Container.new.available?).to be_truthy
    end

    it "should be not available if full" do
      expect(FullContainer.new.available?).to be_falsey
    end
  end

  context "Storing packages" do
    it "fails when is full" do
      container = FullContainer.new

      package = Package.register("new", "small")
      expect { container.store(package) }.to raise_error(NoSpaceInContainer)
    end
  end
end
