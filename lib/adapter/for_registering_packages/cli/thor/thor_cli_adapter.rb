# frozen_string_literal: true

require "thor"

require_relative "cli_app"

class ThorCliAdapter
  def run(argv)
    CliApp.start(argv)
  end
end
