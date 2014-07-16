using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TechTalk.SpecFlow;

namespace BowlingGameKata
{
    [Binding]
    public class BowlingRulesSteps
    {
	    Game g;
	    
		[Given(@"I have started a game")]
		public void GivenIHaveStartedAGame()
		{
			g = new Game();
		}

		[Given(@"I bowl (.*) gutterballs")]
		public void GivenIBowlGutterballs(int times)
		{
			GivenIBowlPinsTimes(times, 0);
		}

		[Given(@"I bowl (.*) pin[s]? (.*) time[s]?")]
		public void GivenIBowlPinsTimes(int pins, int times)
		{
			for (int i = 0; i < pins; i++)
				g.Roll(times);
		}

		[Given(@"I bowl a spare")]
		public void GivenIBowlASpare()
		{
			g.Roll(5);
			g.Roll(5);
		}

		[Given(@"I bowl a strike")]
		public void GivenIBowlAStrike()
		{
			g.Roll(10);			
		}

		[Given(@"I bowl (.*) strikes")]
		public void GivenIBowlStrikes(int times)
		{
			for(int i = 0; i < times; i++)
				GivenIBowlAStrike();
		}
		
		[Given(@"I bowl a (.*)")]
		public void GivenIBowlA(int pins)
		{
			g.Roll(pins);
		}
		
		[When(@"I complete the game")]
		public void WhenICompleteTheGame()
		{
			
		}

		[Then(@"the score should be (.*)")]
		public void ThenTheScoreShouldBe(int expectedScore)
		{
			Assert.AreEqual(expectedScore, g.Score());
		}

    }
}
