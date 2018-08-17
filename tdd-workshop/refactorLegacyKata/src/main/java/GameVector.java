import java.awt.geom.Point2D;

public class GameVector {

    public static GameVector create(final double angle, final double distance) {
        final boolean shouldReverse = shouldReverse(angle);
        final VectorDirection direction = shouldReverse ? VectorDirection.LEFT
                : VectorDirection.RIGHT;
        return new GameVector(Math.tan(angle), distance, direction);
    }

    private static boolean shouldReverse(double angle) {
        angle = angle % (Math.PI * 2);
        final boolean shouldReverse = (angle > Math.PI / 2 && angle <= 3 * Math.PI / 2)
                || (angle < -(Math.PI / 2) && angle >= -(3 * Math.PI / 2));
        return shouldReverse;
    }
    final double slope;
    final double distance;
    final VectorDirection direction;

    public GameVector(final double slope, final double distance,
                      final VectorDirection direction) {
        this.slope = Double.isNaN(slope) ? 0 : slope;
        this.distance = distance;
        this.direction = direction;
    }

    public GameVector add(final GameVector additionalVector) {
        double angle1;
        if (direction.equals(VectorDirection.LEFT)) {
            angle1 = Math.atan(slope) + Math.PI;
        } else if (Math.atan(slope) < 0) {
            angle1 = Math.atan(slope) + Math.PI * 2;
        } else {
            angle1 = Math.atan(slope);
        }
        double angle;
        if (additionalVector.direction.equals(VectorDirection.LEFT)) {
            angle = Math.atan(additionalVector.slope) + Math.PI;
        } else if (Math.atan(additionalVector.slope) < 0) {
            angle = Math.atan(additionalVector.slope) + Math.PI * 2;
        } else {
            angle = Math.atan(additionalVector.slope);
        }
        final double finalX = new Point2D.Double(Math.cos(angle1) * distance, Math.sin(angle1) * distance).getX() + new Point2D.Double(Math.cos(angle) * additionalVector.distance, Math.sin(angle) * additionalVector.distance).getX();
        final double finalY = new Point2D.Double(Math.cos(angle1) * distance, Math.sin(angle1) * distance).getY() + new Point2D.Double(Math.cos(angle) * additionalVector.distance, Math.sin(angle) * additionalVector.distance).getY();
        return new GameVector(finalY / finalX, Math.sqrt(finalX * finalX + finalY * finalY), finalX < 0 ? VectorDirection.LEFT : VectorDirection.RIGHT);
    }

    public double getAngle() {
        return getAngle(this.slope, this.direction);
    }

    public static double getAngle(final double slope,
                                  final VectorDirection direction) {
        final double arctanAngle = Math.atan(slope);
        if (direction.equals(VectorDirection.LEFT)) {
            return arctanAngle + Math.PI;
        } else if (arctanAngle < 0) {
            return arctanAngle + Math.PI * 2;
        } else {
            return arctanAngle;
        }
    }

    public enum VectorDirection {RIGHT, LEFT;}
}
