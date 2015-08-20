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
        log().info("Received a message");
        return ReceiveBuilder
                .match(ScoreGame.class, o -> {
                    log().info("Score: ", Arrays.toString(o.attempts));
                    sender().tell(new GameScored(0), self());
                })
                .matchAny(this::unhandled)
                .build();
    }
}
