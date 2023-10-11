# frozen_string_literal: true

require_relative "no_action"

require_relative "register_package_action"

require_relative "action_factory"

class CliAdapter
  def initialize(action_factory)
    @action_factory = action_factory
  end

  def run(args)
    action = @action_factory.for_subcommand(args)
    puts(action.execute)
  end
end
