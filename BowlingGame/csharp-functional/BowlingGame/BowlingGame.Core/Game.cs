using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BowlingGame.Core
{
    public class Game
    {
	    public List<int> rolls = new List<int>();

	    public void Roll(int pins)
	    {
		    rolls.Add(pins);
	    }

	    public int Score()
	    {
		    return rolls.ToFrames().Take(10).Sum(frame => frame.Sum());
	    }
    }

	public static class BowlingRules
	{
		public static IEnumerable<IEnumerable<int>> ToFrames(this IEnumerable<int> rolls)
		{
			yield return rolls.Take(rolls.BallsToScore());
			foreach (var frame in rolls.Skip(rolls.FrameAdvance()).ToFrames())
				yield return frame;
		}

		private static int FrameAdvance(this IEnumerable<int> rolls)
		{
			return rolls.IsStrike() ? 1 : 2;
		}

		private static int BallsToScore(this IEnumerable<int> rolls)
		{
			return IsBonus(rolls) ? 3 : 2;
		}

		private static bool IsBonus(IEnumerable<int> rolls)
		{
			return rolls.IsStrike() || rolls.IsSpare();
		}

		private static bool IsStrike(this IEnumerable<int> rolls)
		{
			return rolls.Take(1).Sum().Equals(10);
		}

		private static bool IsSpare(this IEnumerable<int> rolls)
		{
			return rolls.Take(2).Sum().Equals(10);
		}
	}
}
