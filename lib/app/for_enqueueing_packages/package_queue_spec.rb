# frozen_string_literal: true

require "rspec"
require_relative "../domain/package"

shared_examples "a PackageQueue" do
  it { is_expected.to respond_to(:put).with(1).argument }

  before do
    @queue = described_class.new
  end

  describe ".put" do
    it "accepts packages" do
      a_package = Package.register("locator")
      @queue.put(a_package)

      expect(@queue).to include(a_package)
    end
  end
end
