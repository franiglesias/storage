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
    it "should return a container with enough space" do
      container = @containers.available

      expect(container).to be_a(Container)
    end

    it "should return nil if no container with available space" do
      @containers.update(FullContainer.new)
      container = @containers.available

      expect(container).to be_nil
    end
  end

  describe ".update" do
    it "updates container info" do
      container = Container.new
      container.store(SmallPackage.new("locator"))
      @containers.update(container)
      recovered = @containers.available
      expect(recovered.contains?("locator")).to be_truthy
    end
  end
end
