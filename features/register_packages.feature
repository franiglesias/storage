Feature: Registering packages
  Packages are registered and assigned to a container where they will be stored

  Rules:
    - Packages can have sizes of 1, 2 or 3 volumes
    - Containers can have capacity for 4, 6 or 8 volumes
    - A Package that cannot be allocated goes to a waiting queue

  Scenario: There is space for allocating package
    Given Merry brings a package
    When package is registered
    Then it is assigned to a container
