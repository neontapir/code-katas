import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runners.Parameterized.Parameters;

import java.util.Collection;

public abstract class BaseTennisTest {

  private int player1Score;
  private int player2Score;
  private String expectedScore;
  private GameFactory gameFactory;

  @FunctionalInterface
  interface GameFactory {
    ITennisGame makeGame(String player1Name, String player2Name);
  }
  
  public BaseTennisTest(int player1Score, int player2Score, String expectedScore, GameFactory gameFactory) {
    this.player1Score = player1Score;
    this.player2Score = player2Score;
    this.expectedScore = expectedScore;
    this.gameFactory = gameFactory;
  }

  @Parameters(name = " {0}-{1} is {2} ")
  public static Collection<Object[]> getAllScores() {
    return TestData.getTestCases();
  }
  
  @Test
  public void scoreIsCorrect() {
    ITennisGame game = this.gameFactory.makeGame("player1", "player2");
    
    scorePoints(game, "player1", this.player1Score);
    scorePoints(game, "player2", this.player2Score);
    
    assertEquals(this.expectedScore, game.getScore());
  }
  
  private void scorePoints(ITennisGame game, String player, int points) {
    for (int i = 0; i < points; i++) {
      game.wonPoint(player);
    }
  }

}
