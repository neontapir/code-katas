package bowling;

public class GameScored {
    public int result;

    public GameScored(int result) {
        this.result = result;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        GameScored that = (GameScored) o;

        return result == that.result;

    }

    @Override
    public int hashCode() {
        return result;
    }
}
