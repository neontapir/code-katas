package bowling;

import org.junit.Test;

import static org.junit.Assert.*;

public class FrameTest {
    @Test
    public void canGetFirstFrame() {
        int[] input = new int[] {0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Frame frame = new Frame(input, 1);
        assertArrayEquals(new int[] {0,1,2}, frame.getFrame());
    }

    @Test
    public void canGetSecondFrame() {
        int[] input = new int[] {0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Frame frame = new Frame(input, 2);
        assertArrayEquals(new int[]{2,3,4}, frame.getFrame());
    }

    @Test
    public void canGetLastFrame() {
        int[] input = new int[] {0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Frame frame = new Frame(input, 10);
        assertArrayEquals(new int[]{0,1,0}, frame.getFrame());
    }

    @Test
    public void canScoreFrame() {
        int[] input = new int[] {0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Frame frame = new Frame(input, 1);
        assertEquals(1, frame.getScore());
    }

    @Test
    public void canScoreSpare() {
        int[] input = new int[] {0,10,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Frame frame = new Frame(input, 1);
        assertEquals(12, frame.getScore());
    }
}
