namespace BowlingGameKata
{
	public class Game
	{
		int[] rolls = new int[21];
		private int currentRoll = 0;

		public void Roll(int i)
		{			
			rolls[currentRoll++] += i;
		}

		public int Score()
		{
			var score = 0;
			var rollIndex = 0;
			for (int frame = 0; frame < 10; frame++)
			{
				if (IsStrike(rollIndex))
				{
					score += 10 + StrikeBonus(rollIndex);
					rollIndex++;
				}
				else
				{
					if (IsSpare(rollIndex))
					{						
						score += 10 + SpareBonus(rollIndex);
					}
					else
					{
						score += SumOfPinsInFrame(rollIndex);
					}
					rollIndex += 2;
				}
			}
			return score;
		}

		private int StrikeBonus(int rollIndex)
		{
			return rolls[rollIndex + 1] + rolls[rollIndex + 2];
		}

		private int SpareBonus(int rollIndex)
		{
			return rolls[rollIndex + 2];
		}

		private int SumOfPinsInFrame(int rollIndex)
		{
			return rolls[rollIndex] + rolls[rollIndex + 1];
		}

		private bool IsStrike(int i)
		{
			return rolls[i] == 10;
		}

		private bool IsSpare(int i)
		{
			return rolls[i] + rolls[i + 1] == 10;
		}
	}
}