using System.Collections.Generic;

namespace csharp_xunit
{
    public class Game
    {
        private List<int> results = new List<int>();

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

        public void Roll(int roll) => results.Add(roll);

        private int Get(int i)
        {
            // with Linq, could do results.ElementAtOrDefault(i);
            return (i < results.Count) ? results[i] : 0;
        }
    }
}
