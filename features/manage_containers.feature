Feature: Managing containers
  We can add and remove containers in the collection
  Allowing different combinations of small, medium and large

  Rules:
  - Containers can have capacity for 4, 6 or 8 volumes, so:
  * Small = 4 vol
  * Medium = 6 vol
  * Large = 8 vol

  Scenario: Adding containers to empty collection
    Given There are no containers in collection
    When Pippin adds a new container
    Then 1 container is available

  Scenario: Several containers
    Given There are no containers in collection
    When Pippin configures these containers
      | size   | quantity |
      | small  | 1       |
      | medium | 1        |
      | large  | 1        |
    Then 3 containers are available
