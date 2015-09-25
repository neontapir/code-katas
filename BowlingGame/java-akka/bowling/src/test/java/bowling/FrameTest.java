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
import scala.concurrent.duration.FiniteDuration;
import java.util.concurrent.TimeUnit;
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
        getScoreFromFrameActor(frame, new ScoreFrame(), new ScoredFrame(1, 1));
    }

    @Test
    public void canScoreSpare() throws Exception {
        int[] input = new int[] {0,10,2,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        int frameNumber = 1;
        Props props = Props.create(Frame.class, input, frameNumber);
        frame = TestActorRef.create(system, props);
        getScoreFromFrameActor(frame, new ScoreFrame(), new ScoredFrame(1, 12));
    }

    @Test
    public void canScoreStrike() throws Exception {
        int[] input = new int[] {10,1,5,3,4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1};
        int frameNumber = 1;
        Props props = Props.create(Frame.class, input, frameNumber);
        frame = TestActorRef.create(system, props);
        getScoreFromFrameActor(frame, new ScoreFrame(), new ScoredFrame(1, 16));
    }

    // sync testing model
    private void getFrameFromFrameActor(GetFrame frameSignal, int[] expected) throws Exception {
        new JavaTestKit(system) {{
            Future<Object> future = Patterns.ask(frame, frameSignal, 1000);
            assertTrue(future.isCompleted());

            GotFrame actual = (GotFrame)Await.result(future, Duration.Zero());

            assertArrayEquals(expected, actual.frame);
        }};
    }

    // async testing model
    private void getScoreFromFrameActor(TestActorRef<Frame> frame, ScoreFrame frameSignal, ScoredFrame expected) throws Exception {
        new JavaTestKit(system) {{
            frame.tell(frameSignal, getRef());
            expectMsgEquals(FiniteDuration.apply(500, TimeUnit.MILLISECONDS), expected);
        }};
    }
}
