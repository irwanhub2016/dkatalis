@midtrans
Feature: Purchases

  @continue
  Scenario Outline: User try to purchase pillow that have status
    Given user access to main page
    When user able to purchase a pillow with '<status>'
    Then user verify purchase should be '<status>' created
	Examples:
		| status   	|
		| success 	|
		| failed 	|