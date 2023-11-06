# frozen_string_literal: true

require "rspec"
require_relative "../domain/container/container"
require_relative "../domain/package/package"
require_relative "../domain/available_containers"
require_relative "configure/already_installed"

shared_examples "a Containers" do
  it { is_expected.to respond_to(:available) }
  it { is_expected.to respond_to(:install) }
  it { is_expected.to respond_to(:configured?) }
  it { is_expected.to respond_to(:configuration) }

  before do
    @containers = described_class.new
  end

  describe ".available" do
    it "should return a collection of containers" do
      expect(@containers.available).to be_an_instance_of(AvailableContainers)
    end

    it "should return no containers if none configured" do
      expect(@containers.available).to eq(AvailableContainers.empty)
    end

    it "should return empty if no container with available space" do
      @containers.add(FullContainer.new("f"))
      expect(@containers.available).to eq(AvailableContainers.empty)
    end

    it "should return only containers that have available space" do
      small_container = SmallContainer.new("s")
      medium_container = MediumContainer.new("m")

      @containers.add(small_container)
      @containers.add(medium_container)
      expect(@containers.available.list).to eq([
        small_container, medium_container
      ])
    end
  end

  describe ".configured?" do
    it "should indicate that containers are not configured" do
      expect(@containers.configured?).to be_falsey
    end

    it "should indicate that containers are configured" do
      @containers = described_class.configure({small: 3})
      expect(@containers.configured?).to be_truthy
    end
  end

  describe ".install" do
    it "should have capacity of containers configured" do
      @containers.install({small: 1})
      expect(@containers.total_space).to eq(Capacity.new(4))
    end
    it "should have capacity of containers combined" do
      @containers.install({small: 2, medium: 2})
      expect(@containers.total_space).to eq(Capacity.new(20))
    end
    it "should fail if already configured" do
      @containers = described_class.configure({small: 2})

      expect {
        @containers.install({small: 4})
      }.to raise_error(AlreadyInstalled)
    end
  end

  describe ".configuration" do
    it "should show 0 containers of each type if not configured" do
      conf = @containers.configuration
      expect(conf.small).to eq(0)
      expect(conf.medium).to eq(0)
      expect(conf.large).to eq(0)
    end

    it "should show current configuration" do
      @containers.install({small: 2, medium: 4, large: 5})
      conf = @containers.configuration
      expect(conf.small).to eq(2)
      expect(conf.medium).to eq(4)
      expect(conf.large).to eq(5)
    end
  end
end
