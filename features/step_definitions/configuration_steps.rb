require_relative "../../setup/cli_adapter_factory"

Given(/^the system is not configured$/) do
  @storage = CliAdapterFactory.for_test({})
  @arguments = ["configure"]
end

Given(/^the system is already configured with$/) do |table|
  configuration = configuration_from(table)

  @storage = CliAdapterFactory.for_test(configuration)
  @arguments = ["configure"]
end

When(/^Merry sends no configuration$/) do
  @output = capture_stdout { @storage.run(%w[configure]) }
end

Then(/^System shows status$/) do |text|
  @output = capture_stdout { @storage.run(@arguments) }
  expect(@output.strip).to eq(text)
end

When(/^Merry configures (\d+) "([^"]*)" containers$/) do |qty, size|
  @arguments.append "--#{size}=#{qty}"
end

def capture_stdout
  original = $stdout
  foo = StringIO.new
  $stdout = foo
  yield
  $stdout.string
ensure
  $stdout = original
end

def configuration_from(table)
  definitions = table.raw.drop(1)

  configuration = {}
  definitions.each do |size, qty|
    qty.to_i.times do
      configuration[size.to_sym] = qty.to_i
    end
  end
  configuration
end
