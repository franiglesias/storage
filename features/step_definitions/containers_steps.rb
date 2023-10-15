Given(/^There are no containers in collection$/) do
  @containers = InMemoryContainers.new
end

When(/^Pippin adds a new container$/) do
  @added_container = Container.of_capacity("small")
  @expected = @added_container.capacity
  @containers.add(@added_container)
end

Then(/^(\d+) containers? (is|are) available$/) do |number, _|
  available = @containers.available

  as_list = available.list
  expect(as_list.size).to eq(number)
end

When(/^Pippin configures these containers$/) do |table|
  configuration = configuration_from(table)

  @containers = InMemoryContainers.configure(configuration)
end

private

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
