package bowling;

import akka.actor.AbstractLoggingActor;
import akka.actor.ActorRef;
import akka.actor.Props;
import akka.japi.Creator;
import akka.japi.pf.ReceiveBuilder;
import scala.PartialFunction;
import scala.runtime.BoxedUnit;

import java.util.Arrays;
import java.util.Hashtable;
import java.util.UUID;

public class Game extends AbstractLoggingActor {
    public Hashtable<Integer, Integer> frameScores;
    ActorRef querent;

    public Game() {
        log().info("Game started");
        frameScores = new Hashtable<>();
    }

    public static Props props() {
        return Props.create(new Creator<Game>() {
            private static final long serialVersionUID = 1L;

            @Override
            public Game create() throws Exception {
                return new Game();
            }
        });
    }

    @Override
    public PartialFunction<Object, BoxedUnit> receive() {
        return ReceiveBuilder
                .match(ScoreGame.class, o -> {
                    log().info("Score game {}: {}", Arrays.toString(o.attempts));
                    querent = sender();
                    calculateScore(o.attempts);
                })
                .match(ScoredFrame.class, o -> {
                    log().debug("Got frame {} result: {}", o.frameNumber, o.score);
                    frameScores.put(o.frameNumber, o.score);
                    // TODO: If we have all of them, send a ScoredGame result
                    if (checkReceivedAllFrames()) {
                        int sum = sumFrames();
                        log().debug("All frames received, send total: {}", sum);
                        querent.tell(new ScoredGame(sum), self());
                    }
                })
                .matchAny(this::unhandled)
                .build();
    }

    private int sumFrames() {
        int sum = 0;
        for(int v : frameScores.values()) {
            sum += v;
        }
        return sum;
    }

    private boolean checkReceivedAllFrames() {
        boolean haveReceivedAllFrames = true;
        for(int i = 1; i <= 10; i++) {
            if (!frameScores.containsKey(i)) {
                haveReceivedAllFrames = false;
                break;
            }
        }
        return haveReceivedAllFrames;
    }

    private void calculateScore(int[] attempts) {
        for (int n = 1; n <= 10; n++) {
            ActorRef frame = getContext().actorOf(Frame.props(attempts, n));
            frame.tell(new ScoreFrame(), self());
        }
    }

    @Override
    public String toString() {
        return "Game{" +
                "frameScores=" + frameScores +
                '}';
    }
}
