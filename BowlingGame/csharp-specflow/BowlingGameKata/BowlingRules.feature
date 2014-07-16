Feature: Bowling Rules
	In order to avoid scoring mistakes
	As a bowler
	I want to get the score of a completed game

Background: 
	Given I have started a game

Scenario: Gutter game
	Given I bowl 20 gutterballs
	When I complete the game
	Then the score should be 0

Scenario: All ones
	Given I bowl 1 pin 20 times
	When I complete the game
	Then the score should be 20

Scenario: One spare
	Given I bowl a spare
		And I bowl a 3
		And I bowl 17 gutterballs
	When I complete the game
	Then the score should be 16

Scenario: One strike
	Given I bowl a strike
		And I bowl a 4
		And I bowl a 3
		And I bowl 17 gutterballs
	When I complete the game
	Then the score should be 24

Scenario: Perfect game
	Given I bowl 12 strikes		
	When I complete the game
	Then the score should be 300
