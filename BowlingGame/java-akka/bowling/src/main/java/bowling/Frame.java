package bowling;

import scala.Array;

import java.util.ArrayList;
import java.util.Arrays;

public class Frame {
    private int[] attempts;
    private int number;
    private int[] frame;

    public Frame(int[] attempts, int number) {
        this.attempts = attempts;
        this.number = number;
    }

    public int[] getFrame() {
        int i = 0;
        int frame = 1;
        while(i < 21 || frame < 11) {
            if (frame == number) {
                int[] attemptsWithZero = concat(attempts, new int[]{0});
                return Arrays.copyOfRange(attemptsWithZero, i, i+3);
            }
            if(attempts[i] == 10) {
                i++;
            } else {
                i += 2;
            }
            frame++;
        }
        return new int[0];
    }

    public int getScore() {
        int[] frame = getFrame();
        int sum = 0;
        if (frame[0] + frame[1] == 10) {
            sum += frame[2];
        }
        sum += frame[0] + frame[1];
        return sum;
    }

    private int[] concat(int[] a, int[] b) {
        int aLen = a.length;
        int bLen = b.length;
        int[] c= new int[aLen+bLen];
        System.arraycopy(a, 0, c, 0, aLen);
        System.arraycopy(b, 0, c, aLen, bLen);
        return c;
    }
}
