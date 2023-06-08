# frozen_string_literal: true

require_relative "./available_container_response"

class AvailableContainerHandler
  def handle(available_container)
    AvailableContainerResponse.new
  end
end
