public class GameController {
  private Game game;
  private Tutorial tutorial = new Tutorial();
  private boolean hasGameStarted = false;

  private final SoundFile scoredSound = new SoundFile(pong.this, "scored-sound.wav");
  private final float playerSpeed = 10;

  public GameController(Game game) {
    this.game = game;
    setRandomSpeeds();
  }

  public void setRandomSpeeds() {
    game.setDeltaX((random(0, 1) < 0.5 ? -1 : 1) * cos(random(0, PI / 4)));
    game.setDeltaY((random(0, 1) < 0.5 ? -1 : 1) * sin(random(0, PI / 4)));
  }

  public void startGame() {
    hasGameStarted = true;
  }

  private void movePlayerOne() {
    if (isWPressed) {
      game.movePlayerOne(-playerSpeed);
    } else if (isSPressed) {
      game.movePlayerOne(playerSpeed);
    }
  }

  private void movePlayerTwo() {
    if (isUpPressed) {
      game.movePlayerTwo(-playerSpeed);
    } else if (isDownPressed) {
      game.movePlayerTwo(playerSpeed);
    }
  }

  private void newPoint() {
    delay(1000);
    game.resetBoard();
    setRandomSpeeds();
  }

  public void checkIfGameStarted(){
    if (isEnterPressed) {
      hasGameStarted = true;
    }
  }

  public void showTutorial() {
    tutorial.draw();
  }

  public void runGame() {
    game.moveBall();
    movePlayerOne();
    movePlayerTwo();

    if (game.hasPlayerOneScored()) {
      game.increasePlayerOneCounter();
      scoredSound.play();
      newPoint();
    } else if (game.hasPlayerTwoScored()) {
      game.increasePlayerTwoCounter();
      scoredSound.play();
      newPoint();
    }

    game.draw();
  }

  public void run() {
    if (!hasGameStarted) {
      checkIfGameStarted();
      showTutorial();
    } else {
      runGame();
    }
  }
}
