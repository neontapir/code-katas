package bowling;

public class ScoredFrame {
    public int frameNumber;
    public int score;

    public ScoredFrame(int frameNumber, int score) {
        this.frameNumber = frameNumber;
        this.score = score;
    }

    @Override
    public String toString() {
        return "ScoredFrame{" +
                "frameNumber=" + frameNumber +
                ", score=" + score +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ScoredFrame that = (ScoredFrame) o;

        if (score != that.score) return false;
        return frameNumber == that.frameNumber;

    }

    @Override
    public int hashCode() {
        int result = score;
        result = 31 * result + frameNumber;
        return result;
    }
}
