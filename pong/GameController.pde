public class GameController {
  private Game game;
  private Tutorial tutorial = new Tutorial();
  private float playerSpeed = 10;
  private boolean hasGameStarted = false;

  public GameController(Game game) {
    this.game = game;
    setRandomSpeeds();
  }

  public void setRandomSpeeds() {
    game.setSpeedX(1);//(random(0, 1) < 0.5 ? -1 : 1) * random(7, 9);
    game.setSpeedY(0);//(random(0, 1) < 0.5 ? -1 : 1) * random(1, 4);
  }

  public void startGame() {
    hasGameStarted = true;
  }

  private void movePlayerOne() {
    if (isWPressed) {
      game.movePlayerOne(-playerSpeed);
    } else if(isSPressed) {
      game.movePlayerOne(playerSpeed);
    }
  }

  private void movePlayerTwo() {
    if (isUpPressed) {
      game.movePlayerTwo(-playerSpeed);
    } else if(isDownPressed) {
      game.movePlayerTwo(playerSpeed);
    }
  }

  private void restartGame() {
    delay(1000);
    game.resetBoardPositions();
    setRandomSpeeds();
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
      restartGame();
    } else if (game.hasPlayerTwoScored()) {
      game.increasePlayerTwoCounter();
      game.resetBoardPositions();
      restartGame();
    }

    game.draw();
  }

  public void run() {
    if (!hasGameStarted) {
      showTutorial();
    } else {
      runGame();
    }
  }
}
