import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import java.util.Collection;

@RunWith(Parameterized.class)
public class TennisGameMediumTest extends BaseTennisTest {
  
  @Parameters(name = " {0}-{1} is {2} ")
  public static Collection<Object[]> getAllScores() {
    return TestData.getTestCases();
  }

  public TennisGameMediumTest(int player1Score, int player2Score, String expectedScore) {
    super(player1Score, player2Score, expectedScore, TennisGameMedium::new);
  }

}