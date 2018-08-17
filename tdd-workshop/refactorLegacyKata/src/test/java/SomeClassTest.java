import static org.junit.Assert.*;

import org.junit.Ignore;
import org.junit.Test;

@Ignore("Remove this line when you're ready to run the tests")
public class SomeClassTest {

	@Test
    public void shouldFailSometimesAndPassSometimesWhichIsAbsolutelyUseless() {
		SomeClass someClass = new SomeClass();
		assertEquals("Tofu", someClass.someMethod());
    }
}
