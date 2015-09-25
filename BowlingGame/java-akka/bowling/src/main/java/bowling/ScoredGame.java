package bowling;

public class ScoredGame {
    public int result;

    public ScoredGame(int result) {
        this.result = result;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ScoredGame that = (ScoredGame) o;

        return result == that.result;

    }

    @Override
    public int hashCode() {
        return result;
    }

    @Override
    public String toString() {
        return "ScoredGame{" +
                "result=" + result +
                '}';
    }
}
