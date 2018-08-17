import static org.junit.Assert.*;

import org.junit.Test;

public class FizzBuzzTest {

	@Test
    public void shouldReturn1for1() {
		FizzBuzz fizzBuzz = new FizzBuzz();
        String actualReturnValue = fizzBuzz.process(1);
        String expectedReturnValue = "1";
        assertEquals(expectedReturnValue, actualReturnValue);
    }
}