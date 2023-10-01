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
    capacity_map = {
      small: 4,
      medium: 6,
      large: 8
    }
    capacity_map.each do |size, capacity|
      it "should create containers of the desired size" do
        c = Container.of_capacity(size)
        expect(c.capacity).to eq(Capacity.new(capacity))
      end
    end
  end

  context "Space available" do
    it "should be available if empty" do
      expect(Container.new.available?).to be_truthy
    end

    it "should be not available if full" do
      expect(FullContainer.new.available?).to be_falsey
    end

    it "should be partially available with only one package" do
      container = Container.of_capacity("small")
      container.store(LargePackage.new("locator-large"))

      package = SmallPackage.new("locator-small")
      expect(container.available?(package)).to be_truthy
    end

    it "should not be available for second large package" do
      container = Container.of_capacity("small")
      container.store(LargePackage.new("locator-large"))

      package = LargePackage.new("other_large")
      expect(container.available?(package)).to be_falsey
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
