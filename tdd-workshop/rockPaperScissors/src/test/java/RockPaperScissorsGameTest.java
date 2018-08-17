import static org.junit.Assert.*;

import org.junit.Ignore;
import org.junit.Test;

@Ignore("Remove this line when you're ready to run the tests")
public class RockPaperScissorsGameTest {

  @Test
  public void rockCrushesScissors() {
    RockPaperScissorsGame game = new RockPaperScissorsGame();
    
    String actualResult = game.determineWinner("rock", "scissors");
    String expectedResult = "rock beats scissors";
    
    assertEquals(expectedResult, actualResult);
  }
}
