# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/adapter/for_registering_packages/cli/option_parser"

RSpec.describe "OptionParser" do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context "When options are not present" do
    it "should return default" do
      parse(
        example: "subcommand",
        option_name: "option",
        default: 0,
        expected: 0
      )
    end
  end

  context "When options are passed" do
    it "should return value of desired option" do
      parse(
        example: "subcommand --option=3",
        option_name: "option",
        default: 0,
        expected: "3"
      )
    end
    it "should return default if not found" do
      parse(
        example: "subcommand --another=3",
        option_name: "option",
        default: 0,
        expected: 0
      )
    end
    it "should return default if value not specified" do
      parse(
        example: "subcommand --option=",
        option_name: "option",
        default: 0,
        expected: 0
      )
    end
  end
end

def parse(default:, example:, expected:, option_name:)
  parser = OptionParser.new(example.split(" "))
  expect(parser.by_name_or_default(option_name, default)).to eq(expected)
end
