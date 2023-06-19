# frozen_string_literal: true

require "rspec"
require_relative "../../../../lib/app/for_registering_packages/register_package/register_package"
require_relative "../../../../lib/app/for_registering_packages/register_package/register_package_handler"

RSpec.describe "RegisterPackageHandler" do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context "registering a package" do
    it "should register package" do
      package_queue = double("PackageQueue")
      expect(package_queue).to receive(:put) do |package|
        expect(package.allocated?).to be_falsey
      end

      command = RegisterPackage.new("some-locator", "small")
      handler = RegisterPackageHandler.new(package_queue)
      handler.handle(command)
    end
  end
end
