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

import static org.junit.Assert.*;

public class FrameTest {
    static ActorSystem system;
    static LoggingAdapter log;
    static TestActorRef<Frame> frame;

    @BeforeClass
    public static void setup() {
        system = ActorSystem.create();
        log = Logging.getLogger(system, FrameTest.class);
    }

    @AfterClass
    public static void teardown() {
        JavaTestKit.shutdownActorSystem(system);
        system = null;
    }

    @Test
    public void canGetFirstFrame() throws Exception {
        int[] input = new int[] {0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Props props = Props.create(Frame.class, input, 1);
        frame = TestActorRef.create(system, props);
        getFrameFromFrameActor(new GetFrame(), new int[] {0,1,2});
    }

    @Test
    public void canGetSecondFrame() throws Exception {
        int[] input = new int[] {0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Props props = Props.create(Frame.class, input, 2);
        frame = TestActorRef.create(system, props);
        getFrameFromFrameActor(new GetFrame(), new int[] {2,3,4});
    }

    @Test
    public void canGetLastFrame() throws Exception {
        int[] input = new int[] {0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Props props = Props.create(Frame.class, input, 10);
        frame = TestActorRef.create(system, props);
        getFrameFromFrameActor(new GetFrame(), new int[]{0, 1, 0});
    }

    @Test
    public void canScoreFrame() throws Exception {
        int[] input = new int[] {0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Props props = Props.create(Frame.class, input, 1);
        frame = TestActorRef.create(system, props);
        getScoreFromFrameActor(new ScoreFrame(), 1);
    }

    @Test
    public void canScoreSpare() throws Exception {
        int[] input = new int[] {0,10,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        Props props = Props.create(Frame.class, input, 1);
        frame = TestActorRef.create(system, props);
        getScoreFromFrameActor(new ScoreFrame(), 12);
    }

//
//    @Test
//    public void canScoreSpare() {
//        int[] input = new int[] {0,10,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
//        Frame frame = new Frame(input, 1);
//        assertEquals(12, frame.getScore());
//    }

    private void getFrameFromFrameActor(GetFrame frameSignal, int[] expected) throws Exception {
        new JavaTestKit(system) {{
            Future<Object> future = Patterns.ask(frame, frameSignal, 1000);
            assertTrue(future.isCompleted());

            GotFrame actual = (GotFrame)Await.result(future, Duration.Zero());

            assertArrayEquals(expected, actual.frame);
        }};
    }

    private void getScoreFromFrameActor(ScoreFrame frameSignal, int expected) throws Exception {
        new JavaTestKit(system) {{
            Future<Object> future = Patterns.ask(frame, frameSignal, 1000);
            assertTrue(future.isCompleted());

            ScoredFrame actual = (ScoredFrame)Await.result(future, Duration.Zero());

            assertEquals(expected, actual.score);
        }};
    }
}
