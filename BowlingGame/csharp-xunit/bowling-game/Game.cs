using System.Collections.Generic;
using Xunit.Abstractions;

namespace BowlingGame
{
    public class Game
    {
        private readonly List<int> rolls = new List<int>();

        public int Score()
        {
            int total = 0;
            int rollIndex = 0;

            for (int frame = 0; frame < 10; frame++)
            {
                int firstRoll = rolls.ElementAtOrDefault(rollIndex);
                int secondRoll = rolls.ElementAtOrDefault(rollIndex + 1);
                int bonusRoll = rolls.ElementAtOrDefault(rollIndex + 2);

                int frameScore = firstRoll + secondRoll;
                if (rolls.ElementAtOrDefault(rollIndex) == 10) // strike
                {
                    frameScore += secondRoll + bonusRoll;
                    rollIndex += 1;
                }
                else if (frameScore == 10) // spare
                {
                    frameScore += bonusRoll;
                    rollIndex += 2;
                }
                else
                {
                    rollIndex += 2;
                }

                total += frameScore;
            }

            return total;
        }

        public void Roll(int pins)
        {
            rolls.Add(pins);
        }
    }
}
