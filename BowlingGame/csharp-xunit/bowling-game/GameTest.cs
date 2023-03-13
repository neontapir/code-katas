using System;
using System.Linq;
using Xunit;
using Xunit.Abstractions;

namespace BowlingGame
{

    public class BowlingGameTest
    {
        Game game;
        private readonly ITestOutputHelper output;

        public BowlingGameTest(ITestOutputHelper output)
        {
            game = new Game();
            this.output = output;
        }

        [Fact]
        public void Can_score_empty_game()
        {
            Assert.Equal(0, game.Score());
        }

        [Fact]
        public void Can_score_singles_game()
        {
            for (int i = 0; i < 20; i++)
            {
                game.Roll(1);
            }
            Assert.Equal(20, game.Score());
        }

        [Fact]
        public void Can_score_frame_with_spares()
        {
            game.Roll(1);
            game.Roll(9); // spare
            game.Roll(3);
            Assert.Equal(16, game.Score());
        }

        [Fact]
        public void Can_score_frame_with_strikes()
        {
            game.Roll(10); // strike
            game.Roll(2); 
            game.Roll(5);
            Assert.Equal(24, game.Score());
        }

        [Fact]
        public void Can_score_perfect_game()
        {
            for (int i = 0; i < 12; i++)
            {
                game.Roll(10); // strike
            }
            Assert.Equal(300, game.Score());
        }
    }
}
