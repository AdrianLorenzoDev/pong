public class Game implements Drawable {
  private int playerOneCounter;
  private int playerTwoCounter;

  private float dX;
  private float dY;
  private float ballSpeed = 10;

  private Ball ball;
  private Paddle playerOne;
  private Paddle playerTwo;


  private final float ballSpeedInc = 0.2;
  private final float ballSpeedMax = 12;
  
  private final int fontSize = 50;
  private final float paddleOffset = 20;
  
  private final int width = int(getRelativeToCanvasWidth(1));
  private final int height = int(getRelativeToCanvasHeight(1));
  
  private final SoundFile paddleCollisionSound = new SoundFile(pong.this, "paddle-collision-sound.wav");
  private final SoundFile sideHitSound = new SoundFile(pong.this, "side-hit-sound.wav");

  public Game() {
    ball = new Ball();
    playerOne = new Paddle();     
    playerTwo = new Paddle();
    resetBoard();
  }

  public void setDeltaX(float dX) {
    this.dX = dX * ballSpeed;
  }

  public void setDeltaY(float dY) {
    this.dY = dY * ballSpeed;
  }

  public void resetBoard() {
    ballSpeed = 10;

    ball.setX(getRelativeToCanvasWidth(0.5));
    ball.setY(getRelativeToCanvasHeight(0.5));

    playerOne.setX(paddleOffset);
    playerOne.setY(getRelativeToCanvasHeight(0.5) - playerOne.getHeight() / 2);

    playerTwo.setX(pixelWidth - paddleOffset - playerTwo.width);
    playerTwo.setY(getRelativeToCanvasHeight(0.5) - playerTwo.getHeight() / 2);
  }

  public boolean hasPlayerOneScored(){
    return ball.getX() > width;
  }

  public boolean hasPlayerTwoScored() {
    return ball.getX() < 0;
  }

  public void movePlayerOne(float speed) {
    float newPos = playerOne.getY() + speed;
    playerOne.setY(min(max(newPos, 0), height-playerOne.getHeight()));
  }

  public void movePlayerTwo(float speed) {
    float newPos = playerTwo.getY() + speed;
    playerTwo.setY(min(max(newPos, 0), height-playerTwo.getHeight()));
  }

  public void increasePlayerOneCounter(){
    playerOneCounter++;
  }

  public void increasePlayerTwoCounter(){
    playerTwoCounter++;
  }

  public void moveBall(){
    ball.setX(dX + ball.getX());
    ball.setY(dY + ball.getY());

    if (ball.getX() < 0 
      || ball.getX() > width) {
      dX = -dX;
      sideHitSound.play();
      return;
    }

    if (ball.getY() < 0 
      || ball.getY() > height) {
      dY = -dY;
      sideHitSound.play();
      return;
    }

    if (dX < 0) {
      float playerOneBallDistance = (ball.getX() - ball.getRadius()) - (playerOne.getX() + playerOne.getWidth());
      
      if (playerOneBallDistance >= -playerOne.getWidth() 
        && playerOneBallDistance <= 0
        && ball.getY() > playerOne.getY() 
        && ball.getY() < playerOne.getY() + playerOne.getHeight()) {
          
        float offset = (ball.getY() + ball.getRadius()*2 - playerOne.getY()) / playerOne.getHeight();
        float rad =  PI / 4 * offset - PI / 4;
        setDeltaY(sin(rad));
        setDeltaX(cos(rad));
        ballSpeed += 0.2;
        paddleCollisionSound.play();
    	  return;
      }
    } else {
      float playerTwoBallDistance = (playerTwo.getX()) - (ball.getX() + ball.getRadius());
      if (playerTwoBallDistance >= -playerTwo.getWidth()
        && playerTwoBallDistance <= 0
        && ball.getY() > playerTwo.getY() 
        && ball.getY() < playerTwo.getY() + playerTwo.getHeight()) {
        
        float offset = (ball.getY() + ball.getRadius()*2 - playerTwo.getY()) / playerTwo.getHeight();
        float rad =  PI / 4 * offset - PI / 4;
        setDeltaY(sin(rad));
        setDeltaX(-cos(rad));
        
        if (ballSpeed < ballSpeedMax) {
          ballSpeed += ballSpeedInc;
        }

        paddleCollisionSound.play();
    	  return;
      }
    }
  }

	private void drawCounters() {
	  textSize(fontSize);
	  text(str(playerOneCounter), getRelativeToCanvasWidth(0.3), getRelativeToCanvasHeight(0.1));
	  text(str(playerTwoCounter), getRelativeToCanvasWidth(0.7), getRelativeToCanvasHeight(0.1));
	}

  private void drawMiddleLine() {
    int numLines = 30;
    int linesHeight = height/numLines;
    for(int i = 0; i < numLines; i=i+2) {
      rect(getRelativeToCanvasWidth(0.5), linesHeight*i, getRelativeToCanvasWidth(0.005), linesHeight);
    }
  }
  
  public void draw() {
		background(0, 0, 0);
		ball.draw();
		playerOne.draw();
		playerTwo.draw();
		drawCounters();
    drawMiddleLine();
	}
}
