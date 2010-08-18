Feature: Manage days
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new day
    Given I am on the new day page
    When I fill in "Datum" with "19.2.2010"
    And I fill in "Bargeldumsatz" with "77.1"
    And I press "Tagesabschluss anlegen"
    Then I should see "19.02.2010"
    And I should see "77.10"

  Scenario: Delete day
    Given the following days:
      |date|cash|
      |7.8.2010|77.30|
      |6.8.2010|88.30|
      |5.8.2010|99.30|
      |4.8.2010|66.30|
    When I delete the 3rd day
    Then I should see the following days:
      |Datum|Bargeldumsatz|
      |07.08.2010|77.30|
      |06.08.2010|88.30|
      |04.08.2010|66.30|
