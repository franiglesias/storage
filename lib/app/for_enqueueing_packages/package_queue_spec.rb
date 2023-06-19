# frozen_string_literal: true

require "rspec"
require_relative "../domain/package"
require_relative "no_more_packages"

shared_examples "a PackageQueue" do
  it { is_expected.to respond_to(:put).with(1).argument }

  before do
    @queue = described_class.new
  end

  describe ".put" do
    it "accepts packages" do
      a_package = Package.register("locator", "small")
      @queue.put(a_package)

      expect(@queue).to include(a_package)
    end
  end

  describe ".get" do
    before do
      @a_package = Package.register("locator", "small")
      @queue.put(@a_package)
    end
    it "gives first package" do
      recovered = @queue.get
      expect(recovered).to be(@a_package)
    end
    it "removes package from queue" do
      @queue.get
      expect { @queue.get }.to raise_error(NoMorePackages)
    end
  end
end
