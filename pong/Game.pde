public class Game implements Drawable {
    private int playerOneCounter;
    private int playerTwoCounter;

    private float dX;
    private float dY;

    private Ball ball;
    private Paddle playerOne;
    private Paddle playerTwo;

    private final int fontSize = 50;
    private final float paddleOffset = 20;
    private final int width = int(getRelativeToCanvasWidth(1));
    private final int height = int(getRelativeToCanvasHeight(1));

    public Game() {
        ball = new Ball();
        playerOne = new Paddle();     
        playerTwo = new Paddle();
        resetBoardPositions();
    }

    public void setSpeedX(float speed) {
        this.dX = speed;
    }

    public void setSpeedY(float speed) {
        this.dY = speed;
    }

    public void resetBoardPositions() {
        ball.setX(getRelativeToCanvasWidth(0.5));
        ball.setY(getRelativeToCanvasHeight(0.5));

        playerOne.setX(paddleOffset);
        playerOne.setY(getRelativeToCanvasHeight(0.5) - playerOne.getHeight() / 2);

        playerTwo.setX(pixelWidth - (paddleOffset * 2));
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
            return;
        }

        if (ball.getY() < 0 
            || ball.getY() > height) {
            dY = -dY;
            return;
        }

        if (dX < 0) {
            float playerOneBallDistance = (ball.getX() - ball.getRadius()) - (playerOne.getX() + playerOne.getWidth());
            if (playerOneBallDistance >= -playerOne.getWidth() 
                && playerOneBallDistance <= 0
                && ball.getY() > playerOne.getY() 
                && ball.getY() < playerOne.getY() + playerOne.getHeight()) {
                dX = -dX;
                dY = -dY;
            	return;
            }
        } else {
            float playerTwoBallDistance = (playerTwo.getX()) - (ball.getX() + ball.getRadius());
            if (playerTwoBallDistance >= -playerTwo.getWidth()
                && playerTwoBallDistance <= 0
                && ball.getY() > playerTwo.getY() 
                && ball.getY() < playerTwo.getY() + playerTwo.getHeight()) {
                dX = -dX;
                dY = -dY;
            	return;
            }
        }
    }
  
	private void drawCounters() {
		textSize(fontSize);
		text(str(playerOneCounter), getRelativeToCanvasWidth(0.3), getRelativeToCanvasHeight(0.1));
		text(str(playerTwoCounter), getRelativeToCanvasWidth(0.7), getRelativeToCanvasHeight(0.1));
	}
  
	public void draw() {
		background(0, 0, 0);
		ball.draw();
		playerOne.draw();
		playerTwo.draw();
		drawCounters();
	}
}
