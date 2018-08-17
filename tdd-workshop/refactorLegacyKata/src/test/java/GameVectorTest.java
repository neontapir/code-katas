import org.junit.Test;

import static org.junit.Assert.*;


public class GameVectorTest {

    private static final double SIG_DIGITS = 0.000000000000001;
    private static final double PI = Math.PI;

    @Test
    public void add_Leftly() throws Exception {
        final GameVector vector1 = new GameVector(0, 10, GameVector.VectorDirection.LEFT);
        final GameVector vector2 = new GameVector(0, 15, GameVector.VectorDirection.LEFT);
        final GameVector result = vector1.add(vector2);
        assertEquals(0, result.slope, SIG_DIGITS);
        assertEquals(25, result.distance, 0);
        assertEquals(GameVector.VectorDirection.LEFT, result.direction);
    }

    @Test
    public void add_Rightly() throws Exception {
        final GameVector vector1 = new GameVector(15, 42, GameVector.VectorDirection.RIGHT);
        final GameVector vector2 = new GameVector(15, 21, GameVector.VectorDirection.RIGHT);
        final GameVector result = vector1.add(vector2);
        assertEquals(15, result.slope, SIG_DIGITS * 10);
        assertEquals(63, result.distance, 0);
        assertEquals(GameVector.VectorDirection.RIGHT, result.direction);
    }

    @Test
    public void add_Angles_KnownRightTriangle() throws Exception {
        final GameVector vector1 = new GameVector(0, 3, GameVector.VectorDirection.RIGHT);
        final GameVector vector2 = new GameVector(Double.POSITIVE_INFINITY, 4,
                GameVector.VectorDirection.RIGHT);
        final GameVector result = vector1.add(vector2);
        assertEquals(5, result.distance, 0);
        assertEquals(GameVector.VectorDirection.RIGHT, result.direction);
    }

    @Test
    public void add_Angles_Known45degreeAngle() throws Exception {
        final GameVector vector1 = new GameVector(0, 10, GameVector.VectorDirection.RIGHT);
        final GameVector vector2 = new GameVector(Double.POSITIVE_INFINITY, 10,
                GameVector.VectorDirection.RIGHT);
        final GameVector result = vector1.add(vector2);
        assertEquals(1.0, result.slope, 0);
        assertEquals(GameVector.VectorDirection.RIGHT, result.direction);
    }

    @Test
    public void oppositeVectorsWillCancelOutToZero() throws Exception {
        final GameVector vector1 = new GameVector(10, 70, GameVector.VectorDirection.LEFT);
        final GameVector vector2 = new GameVector(10, 70, GameVector.VectorDirection.RIGHT);
        final GameVector result = vector1.add(vector2);
        assertEquals(0, result.slope, 0);
        assertEquals(0, result.distance, 0.00000000000001);
    }

    @Test
    public void testAddWillNotReverseDirectionInStrangeSituation_BeCarefulWithCasting()
            throws Exception {
        final GameVector gameVector = new GameVector(-2.0334448160535117, 1,
                GameVector.VectorDirection.LEFT);

        final GameVector result = gameVector.add(gameVector);
        assertEquals(gameVector.slope, result.slope, SIG_DIGITS);
        assertEquals(GameVector.VectorDirection.LEFT, result.direction);
        assertEquals(2, result.distance, 0);
    }

    @Test
    public void testAngleInRadians() throws Exception {
        assertEquals(0, new GameVector(0, 1, GameVector.VectorDirection.RIGHT).getAngle(),
                0);
        assertEquals(Math.PI / 4,
                new GameVector(1, 1, GameVector.VectorDirection.RIGHT).getAngle(), 0);
        assertEquals(Math.PI / 2, new GameVector(Double.POSITIVE_INFINITY, 1,
                GameVector.VectorDirection.RIGHT).getAngle(), 0);
        assertEquals(3 * Math.PI / 2, new GameVector(Double.POSITIVE_INFINITY,
                1, GameVector.VectorDirection.LEFT).getAngle(), 0);
        assertEquals(3 * Math.PI / 2, new GameVector(Double.POSITIVE_INFINITY,
                -1, GameVector.VectorDirection.LEFT).getAngle(), 0);
    }

    @Test
    public void testCreateWithAngle() throws Exception {
        checkCreateWithAngle(0, 10);
        checkCreateWithAngle(PI / 4, 6);
        checkCreateWithAngle(PI / 2, 8);
        checkCreateWithAngle(3 * PI / 4, 8);
        checkCreateWithAngle(PI, 1);
        checkCreateWithAngle(5 * PI / 4, 9);
        checkCreateWithAngle(3 * PI / 2, 11);
        checkCreateWithAngle(7 * PI / 4, 99);
    }

    @Test
    public void testCreateWithAngleTooLarge() throws Exception {
        final int distance = 99;
        final GameVector gameVector = GameVector.create(8.768435912084136,
                distance);
        assertEquals(8.768435912084136 - PI * 2, gameVector.getAngle(),
                SIG_DIGITS);
        assertEquals(distance, gameVector.distance, 0);
    }

    @Test
    public void testCreateWithNegativeAngle() throws Exception {
        final int distance = 6;
        final GameVector gameVector = GameVector.create(-PI / 4, distance);
        assertEquals(7 * PI / 4, gameVector.getAngle(), 0);
        assertEquals(distance, gameVector.distance, 0);
    }

    private void checkCreateWithAngle(final double angle, final double distance) {
        final GameVector gameVector = GameVector.create(angle, distance);
        assertEquals(angle, gameVector.getAngle(), 0);
        assertEquals(distance, gameVector.distance, 0);
    }

}