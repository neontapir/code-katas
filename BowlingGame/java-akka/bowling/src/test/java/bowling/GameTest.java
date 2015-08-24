package bowling;

import akka.actor.ActorSystem;
import akka.actor.Props;
import akka.event.Logging;
import akka.event.LoggingAdapter;
import akka.testkit.JavaTestKit;
import akka.testkit.TestActorRef;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import scala.concurrent.duration.FiniteDuration;

import java.util.concurrent.TimeUnit;

public class GameTest {
    static ActorSystem system;
    static LoggingAdapter log;

    @BeforeClass
    public static void setupClass() {
        system = ActorSystem.create();
        log = Logging.getLogger(system, GameTest.class);

    }

    private static TestActorRef<Game> createGame() {
        Props props = Props.create(Game.class);
        return TestActorRef.create(system, props);
    }

    @AfterClass
    public static void teardownClass() {
        JavaTestKit.shutdownActorSystem(system);
        system = null;
    }

    @Test
    public void gutterGameTest() throws Exception {
        sendScoreToGame(createGame(), new ScoreGame(new int[] {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}), 0);
    }

    @Test
    public void singlePinTest() throws Exception {
        sendScoreToGame(createGame(), new ScoreGame(new int[] {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}), 20);
    }

    @Test
    public void spareTest() throws Exception {
        sendScoreToGame(createGame(), new ScoreGame(new int[] {4,6,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}), 26);
    }

    @Test
    public void strikeTest() throws Exception {
        sendScoreToGame(createGame(), new ScoreGame(new int[] {10,6,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}), 28);
    }

    @Test
    public void perfectGameTest() throws Exception {
        sendScoreToGame(createGame(), new ScoreGame(new int[] {10,10,10,10,10,10,10,10,10,10,10,10}), 300);
    }

    private void sendScoreToGame(TestActorRef<Game> game, ScoreGame scoreThisGame, int expectedScore) throws Exception {
        new JavaTestKit(system) {{
            ScoredGame expected = new ScoredGame(expectedScore);
            game.tell(scoreThisGame, getRef());
            expectMsgEquals(FiniteDuration.apply(500, TimeUnit.MILLISECONDS), expected);
        }};
    }
}
