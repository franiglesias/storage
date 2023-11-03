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

  Scenario: Empty system
    Given the system is not configured
    When Merry configures 2 "small" containers
    Then System shows status
      """
      Configured storage:

      * Small: 2
      * Medium: 0
      * Large: 0
      """
