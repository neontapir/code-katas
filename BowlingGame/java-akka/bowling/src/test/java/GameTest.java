package test.java;

import main.java.Game;
import org.junit.Test;

import static org.junit.Assert.*;

public class GameTest {
    @Test
    public void gutterGameTest() {
        Game g = new Game();
        for(int i=0; i<21; i++) {
            g.roll(0);
        }
        assertEquals(0, g.score());
    }
}
