package bowling;

import akka.actor.AbstractLoggingActor;
import akka.japi.pf.ReceiveBuilder;
import scala.PartialFunction;
import scala.runtime.BoxedUnit;

import java.util.Arrays;

public class Game extends AbstractLoggingActor {
    public Game() {
        log().info("Game started");
    }

    @Override
    public PartialFunction<Object, BoxedUnit> receive() {
        return ReceiveBuilder
                .match(ScoreGame.class, o -> {
                    log().info("Score: {}", Arrays.toString(o.attempts));
                    int result = calculateScore(o.attempts);
                    sender().tell(new GameScored(result), self());
                })
                .matchAny(this::unhandled)
                .build();
    }

    private int calculateScore(int[] attempts) {
        int sum = 0;
        for (int attempt : attempts) {
            sum += attempt;
        }
        return sum;
    }
}
