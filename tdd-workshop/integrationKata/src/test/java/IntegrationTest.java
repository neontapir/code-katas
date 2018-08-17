import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.Ignore;

@Ignore("Remove this line when you're ready to run the tests")
public class IntegrationTest {

    @Test
    public void noNamesShouldReturnNothing() {
        Integration integration = new Integration();
        String actualReturnValue = integration.process("");
        String expectedReturnValue = "";
        assertEquals(expectedReturnValue, actualReturnValue);
    }


    @Test
    public void oneLetterPasswordEncryptsCorrectly() {
        Integration integration = new Integration();
        String actualReturnValue = integration.encryptPassword("z");
        String expectedReturnValue = "z";
        assertEquals(expectedReturnValue, actualReturnValue);
    }
}
