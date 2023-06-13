# frozen_string_literal: true

require "rspec"
require_relative "../domain/container"

shared_examples "a Containers" do
  it { is_expected.to respond_to(:available) }

  before do
    @containers = described_class.new
  end

  describe ".available" do
    it "returns a container with enough space" do
      container = @containers.available

      expect(container).to be_a(Container)
    end
  end
end
