# frozen_string_literal: true

require "rspec"
require_relative "../../../../lib/app/for_managing_containers/configure/get_configuration_handler"
require_relative "../../../../lib/app/for_managing_containers/configure/get_configuration_response"
require_relative "../../../../lib/app/for_managing_containers/configure/get_configuration"

RSpec.describe "GetConfigurationHandler" do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context "when empty containers" do
    it "should show all sizes 0" do
      containers = double("containers")
      allow(containers).to receive(:configuration) {
        r = Struct.new(:small, :medium, :large)
        r.new(0, 0, 0)
      }

      handler = GetConfigurationHandler.new(containers)
      response = handler.handle(GetConfiguration.new)
      expected = GetConfigurationResponse.new(
        small: 0,
        medium: 0,
        large: 0
      )
      expect(response).to eq(expected)
    end
  end
end
