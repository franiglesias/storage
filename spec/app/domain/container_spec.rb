# frozen_string_literal: true

require "rspec"

require_relative "../../../lib/app/domain/container/container"
require_relative "../../../lib/app/domain/package/package"
require_relative "../../../lib/app/domain/container/no_space_in_container"

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
        c = Container.of_capacity(size, "c1")
        expect(c.capacity).to eq(Capacity.new(capacity))
      end
    end
  end

  context "Package management" do
    container = Container.of_capacity("small", "c")
    stored = Package.register("stored", "large")
    container.store(stored)

    it "should not contain a package not stored" do
      expect(container.contains?("not-stored")).to be_falsey
    end

    it "should contain an stored package" do
      expect(container.contains?("stored")).to be_truthy
    end
  end

  context "Space available" do
    container = Container.of_capacity("small", "c")
    container.store(LargePackage.new("locator-large"))

    it "should be available if empty" do
      expect(Container.new("c").has_space_for?).to be_truthy
    end

    it "should be not available if full" do
      expect(FullContainer.new("c").has_space_for?).to be_falsey
    end

    it "should be partially available with only one package" do
      small_package = SmallPackage.new("locator-small")
      expect(container.has_space_for?(small_package)).to be_truthy
    end

    it "should not be available for second large package" do
      large_package = LargePackage.new("other-large")
      expect(container.has_space_for?(large_package)).to be_falsey
    end
  end

  context "Storing packages" do
    it "fails when is full" do
      container = FullContainer.new("f")

      package = Package.register("new", "small")
      expect { container.store(package) }.to raise_error(NoSpaceInContainer)
    end
  end
end
