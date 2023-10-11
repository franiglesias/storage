# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/adapter/for_registering_packages/cli/cli_adapter"
require_relative "../../../../lib/app/for_registering_packages/register_package/register_package"
require_relative "../../../../lib/app/for_registering_packages/available_container/available_container"
require_relative "../../../../lib/app/for_registering_packages/available_container/available_container_response"

RSpec.describe "CliAdapter" do
  before do
    @command_bus = double("CommandBus")
    @query_bus = double("QueryBus")

    action_factory = ActionFactory.new(@command_bus, @query_bus)

    @cli = CliAdapter.new(action_factory)
  end

  after do
    # Do nothing
  end

  context "when receives register subcommand" do
    it "invokes register package command" do
      expect(@command_bus).to receive(:execute).with(RegisterPackage.new("locator", "small"))
      allow(@query_bus).to receive(:execute).with(AvailableContainer.new).and_return(AvailableContainerResponse.new(2))

      args = ["register", "locator", "small"]

      expect {
        @cli.run(args)
      }.to output(/package locator to be stored in container 2/).to_stdout
    end
  end
end
