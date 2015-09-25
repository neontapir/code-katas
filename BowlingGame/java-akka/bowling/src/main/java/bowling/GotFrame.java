package bowling;

import java.util.Arrays;

public class GotFrame {
    public int frameNumber;
    public int[] frame;

    public GotFrame(int frameNumber, int[] frame) {
        this.frameNumber = frameNumber;
        this.frame = frame;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        GotFrame gotFrame = (GotFrame) o;

        if (frameNumber != gotFrame.frameNumber) return false;
        return Arrays.equals(frame, gotFrame.frame);

    }

    @Override
    public int hashCode() {
        int result = frameNumber;
        result = 31 * result + (frame != null ? Arrays.hashCode(frame) : 0);
        return result;
    }
}
