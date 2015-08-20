package bowling;

import akka.actor.ActorSystem;
import akka.actor.Props;
import akka.event.Logging;
import akka.event.LoggingAdapter;
import akka.pattern.Patterns;
import akka.testkit.JavaTestKit;
import akka.testkit.TestActorRef;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import scala.concurrent.Await;
import scala.concurrent.Future;
import scala.concurrent.duration.Duration;
import sun.jvm.hotspot.utilities.Assert;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class GameTest {
    static ActorSystem system;
    static LoggingAdapter log;

    @BeforeClass
    public static void setup() {
        system = ActorSystem.create();
        log = Logging.getLogger(system, GameTest.class);
    }

    @AfterClass
    public static void teardown() {
        JavaTestKit.shutdownActorSystem(system);
        system = null;
    }

    @Test
    public void gutterGameTest() throws Exception {
        log.info("gutterGameTest started");
        sendScoreToGame(new ScoreGame(new int[] {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}), 0);
    }

    private void sendScoreToGame(ScoreGame attempts, int expectedScore) throws Exception {
        new JavaTestKit(system) {{
            GameScored expected = new GameScored(expectedScore);
            Props props = Props.create(Game.class);
            TestActorRef<Game> game = TestActorRef.create(system, props, "game");

            Future<Object> future = Patterns.ask(game, attempts, 3000);
            assertTrue(future.isCompleted());

            Object actual = Await.result(future, Duration.Zero());

            Assert.that(actual instanceof GameScored, "Wrong return type");
            assertEquals(expected, actual);
        }};
    }
}
