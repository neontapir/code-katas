using System;
using System.Linq;
using Xunit;

namespace csharp_xunit
{

    public class BowlingGameTest : IDisposable
    {
        Game game;

        public BowlingGameTest()
        {
            game = new Game();
        }

        public void Dispose()
        {
            game = null;
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
            game.Roll(1); 
            game.Roll(5);
            Assert.Equal(22, game.Score());
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
