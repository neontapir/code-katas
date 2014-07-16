package main;
public class Game {

	private int rolls[] = new int[21];
	private int currentRoll = 0;

	public void roll(int pins) {
		rolls[currentRoll++] = pins;
	}

	public int score() {
		int score = 0;
		int rollNumber = 0;
		for (int frame = 0; frame < 10; frame++) {
			if (isStrike(rollNumber)) {
				score += 10 + strikeBonus(rollNumber);
				rollNumber++;
			} else {
				if (isSpare(rollNumber)) {
					score += 10 + spareBonus(rollNumber);
				} else {
					score += sumOfBallsInFrame(rollNumber);
				}
				rollNumber += 2;
			}
		}
		return score;
	}

	private int spareBonus(int index) {
		return rolls[index + 2];
	}

	private int sumOfBallsInFrame(int index) {
		return rolls[index] + rolls[index + 1];
	}

	private int strikeBonus(int index) {
		return rolls[index + 1] + rolls[index + 2];
	}
	
	private boolean isStrike(int index) {
		return rolls[index] == 10;
	}

	private boolean isSpare(int index) {
		return sumOfBallsInFrame(index) == 10;
	}

}
