package bowling;

import java.util.Arrays;

public class ScoreGame {
    public int[] attempts;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ScoreGame scoreGame = (ScoreGame) o;

        return Arrays.equals(attempts, scoreGame.attempts);

    }

    @Override
    public int hashCode() {
        return Arrays.hashCode(attempts);
    }

    public ScoreGame(int[] attempts) {
        this.attempts = attempts;
    }
}
