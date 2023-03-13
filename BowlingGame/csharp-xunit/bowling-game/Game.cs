using System.Collections.Generic;
using Xunit.Abstractions;

namespace BowlingGame
{
    public class Game
    {
        private List<int> rolls;
        
        public Game()
        {
            rolls = new List<int>();
        }

        //public int Score()
        //{
        //    var result = 0;
        //    var tally = rolls.Concat(new List<int>{0, 0}).ToList();
        //    var i = 0;
        //    while(i < rolls.Count) {
        //        result += tally[i] + tally[i + 1];

        //        var advanceBy = 2;
        //        if (tally[i] == 10)
        //        {
        //            result += tally[i + 2];
        //            advanceBy = 1;
        //        }
        //        else if (tally[i] + tally[i + 1] == 10)
        //        {
        //            result += tally[i + 2];
        //        }

        //        i += advanceBy;
        //    }
        //    return result;
        //}

        //public void Roll(int value)
        //{
        //    rolls.Add(value);
        //}

        public int Score()
        {
            int total = 0;
            int nextItem = 0;
            for (int frame = 0; frame < 10; frame++)
            {
                total += Get(nextItem);
                bool isStrike = Get(nextItem) == 10;
                if (isStrike)
                {
                    total += Get(nextItem + 1) + Get(nextItem + 2);
                    nextItem += 1;
                }
                else
                {
                    total += Get(nextItem + 1);
                    bool isSpare = Get(nextItem) + Get(nextItem + 1) == 10;
                    if (isSpare)
                    {
                        total += Get(nextItem + 2);
                    }
                    nextItem += 2;
                }
            }
            return total;
        }

        public void Roll(int roll) => rolls.Add(roll);

        private int Get(int i)
        {
            // with Linq, could do results.ElementAtOrDefault(i);
            return (i < rolls.Count) ? rolls[i] : 0;
        }
    }
}
