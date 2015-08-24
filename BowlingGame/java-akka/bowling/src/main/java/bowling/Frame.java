package bowling;

import akka.actor.AbstractLoggingActor;
import akka.actor.Props;
import akka.japi.Creator;
import akka.japi.pf.ReceiveBuilder;
import scala.PartialFunction;
import scala.runtime.BoxedUnit;

import java.util.Arrays;

public class Frame extends AbstractLoggingActor {
    private int[] attempts;
    private int number;

    public Frame(int[] attempts, int number) {
        this.attempts = attempts;
        this.number = number;
    }

    public static Props props(int[] attempts, int number) {
        return Props.create(new Creator<Frame>() {
            private static final long serialVersionUID = 1L;

            @Override
            public Frame create() throws Exception {
                return new Frame(attempts, number);
            }
        });
    }

    @Override
    public PartialFunction<Object, BoxedUnit> receive() {
        return ReceiveBuilder
                .match(GetFrame.class, o -> {
                    int[] frame = getFrame();
                    log().debug("Items in frame {} are: {}", number, frame);
                    sender().tell(new GotFrame(number, frame), self());
                })
                .match(ScoreFrame.class, o -> {
                    int frameScore = getScore();
                    log().debug("Score for frame {} is: {}", number, frameScore);
                    sender().tell(new ScoredFrame(number, frameScore), self());
                })
                .matchAny(this::unhandled)
                .build();
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
        // throw here?
        return new int[0];
    }

    public int getScore() {
        int[] frame = getFrame();
        int sum = 0;
        if (frame[0] == 10 || frame[0] + frame[1] == 10) {
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

    @Override
    public String toString() {
        return "Frame{" +
                "number=" + number +
                '}';
    }
}
