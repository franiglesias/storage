Feature: Registering packages
  Packages are registered and assigned to a container where they will be stored

  Rules:
    - Packages can have sizes of 1, 2 or 3 volumes, so:
      * Small = 1 vol
      * Medium = 2 vols
      * Large = 3 vols
    - Containers can have capacity for 4, 6 or 8 volumes, so:
      * Small = 4 vol
      * Medium = 6 vol
      * Large = 8 vol
    - A Package that cannot be allocated goes to a waiting queue

  Scenario: There is space for allocating package
    When Merry registers a package
    Then first available container is located
    And he puts the package into it

  Scenario: There is no enough space for allocating package
    Given no container with enough space
    When Merry registers a package
    Then there is no available container
    And package stays in queue

  Scenario: Having a container with capacity
    Given an empty "small" container
    When Merry registers a "small" size package
    Then package is allocated in container
    And he puts the package into it

  Scenario: Container with packages in it and not enough free space
    Given an empty "small" container
    And a "large" package stored
    When Merry registers a "large" size package
    Then there is no available container
    And package stays in queue
