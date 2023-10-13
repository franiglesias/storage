# frozen_string_literal: true

require "rspec"
require_relative "../domain/container"
require_relative "../domain/package"

shared_examples "a Containers" do
  it { is_expected.to respond_to(:available) }

  before do
    @containers = described_class.new
  end

  describe ".available" do
    it "should return no containers if none configured" do
      expect(@containers.available).to eq([])
    end

    it "should return empty if no container with available space" do
      @containers.add(FullContainer.new)
      expect(@containers.available).to eq([])
    end

    it "should return only containers that have available space" do
      small_container = SmallContainer.new
      medium_container = MediumContainer.new

      @containers.add(small_container)
      @containers.add(medium_container)
      expect(@containers.available).to eq([
        small_container, medium_container
      ])
    end
  end
end
