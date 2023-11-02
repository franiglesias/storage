# frozen_string_literal: true

require_relative "../../setup/cli_adapter_factory"

# There is space for allocating package

Given(/^there is enough capacity$/) do
  enough_capacity_conf = {
    small: 1,
    medium: 1,
    large: 1
  }
  @storage = CliAdapterFactory.for_test(enough_capacity_conf)
end

When("Merry registers a package") do
  @output = capture_stdout { @storage.run(%w[register some-locator small]) }
end

Then("first available container is located") do
  @container_name = @output.split.last
  expect(@container_name).to eq("s-1")
end

Then("he puts the package into it") do
  output = capture_stdout { @storage.run(["store", @container_name]) }
  expect(output).to eq("package stored in container #{@container_name}\n")
end

# There is no enough space for allocating package

Given("no container with enough space") do
  no_container_conf = {}
  @storage = CliAdapterFactory.for_test(no_container_conf)
end

Then("there is no available container") do
  expect(@output).to include("no space available")
end

Then("package stays in queue") do
  expect(@output).to include("Package some-locator is in waiting queue")
end

# Having a container with capacity
#
Given("an empty {string} container") do |capacity|
  one_container_conf = {}
  one_container_conf[capacity.to_sym] = 1
  @storage = CliAdapterFactory.for_test(one_container_conf)
end

When("Merry registers a {string} size package") do |size|
  @output = capture_stdout { @storage.run(["register", "some-locator", size]) }
end

Then("package is allocated in container") do
  @container_name = @output.split.last
  expect(@container_name).to eq("s-1")
end

# Container with packages in it and not enough free space

Given("a {string} package stored") do |size|
  output = capture_stdout { @storage.run(["register", "large-pkg", size]) }
  container_name = output.split.last
  @storage.run(["store", container_name])
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
