import static org.junit.Assert.*;

import org.junit.Ignore;
import org.junit.Test;

@Ignore("Remove this line when you're ready to run the tests")
public class RomanNumeralCalculatorTest {

  @Test
  public void onePlusOneIsTwo() {
    RomanNumeralCalculator calculator = new RomanNumeralCalculator();

    String actualResult = calculator.add("I", "I");
    String expectedResult = "II";

    assertEquals(expectedResult, actualResult);
  }
}
