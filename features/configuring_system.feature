Feature: Configuring the system
  We can configure the system with an arbitrary number of containers with different sizes

  Rules:
  - Containers can have capacity for 4, 6 or 8 volumes, so:
  * Small = 4 vol
  * Medium = 6 vol
  * Large = 8 vol

  Scenario: Empty system
    Given the system is not configured
    When Merry sends no configuration
    Then System shows status
      """
      Configured storage:

      System is not configured
      """

  Scenario: Adding one size of containers
    Given the system is not configured
    When Merry configures 2 "small" containers
    Then System shows status
      """
      Configured storage:

      * Small:  2
      * Medium: 0
      * Large:  0
      """

  Scenario: Adding all containers sizes
    Given the system is not configured
    When Merry configures 2 "small" containers
    And Merry configures 4 "medium" containers
    And Merry configures 3 "large" containers
    Then System shows status
      """
      Configured storage:

      * Small:  2
      * Medium: 4
      * Large:  3
      """

  Scenario: Configured system
    Given the system is already configured with
      | size   | qty |
      | small  | 2   |
      | medium | 4   |
      | large  | 3   |
    When Merry configures 5 "small" containers
    And Merry configures 2 "medium" containers
    And Merry configures 1 "large" containers
    Then System shows status
      """
      Configured storage:

      System is already configured

      * Small:  2
      * Medium: 4
      * Large:  3
      """
