Feature: Registering packages
  Packages are registered and assigned to a container where they will be stored

  Rules:
    - Packages can have sizes of 1, 2 or 3 volumes
    - Containers can have capacity for 4, 6 or 8 volumes
    - A Package that cannot be allocated goes to a waiting queue

  Scenario: There is space for allocating package
    When Merry registers a package
    Then first available container is located
    And he puts the package into it

  Scenario: There is no enough space for allocating package
    Given no container with enough space
    When Merry registers a package
    Then package stays in queue
