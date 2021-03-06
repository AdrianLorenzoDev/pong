public class Tutorial implements Drawable {
  private final float h = getRelativeToCanvasWidth(0.9);
  private final float w = getRelativeToCanvasHeight(0.6);

  private final float rectX = getRelativeToCanvasWidth(0.5) - w/2;
  private final float rectY = getRelativeToCanvasHeight(0.5) - h/2;

  private final float textWidth = getRelativeToCanvasWidth(0.8);
  private final float textHeight = getRelativeToCanvasHeight(0.3);

  private final float textX = rectX + getRelativeToCanvasWidth(0.1);

  private final float playerOneTextY = rectY + getRelativeToCanvasHeight(0.1);
  private final float playerTwoTextY = rectY + getRelativeToCanvasHeight(0.4);
  private final float startTextY = rectY + getRelativeToCanvasHeight(0.7);

  private final PFont font = createFont("Arial", 20);

  public void draw() {
    stroke(255, 255, 255);
    fill(0, 0, 0);
    rect(rectX, rectY, w, h);

    textFont(font);

    fill(255, 255, 255);
    text("Player 1: \n[W => Up] \n[S => Down]", textX, playerOneTextY, textWidth, textHeight);

    fill(255, 255, 255);
    text("Player 2: \n[Arrow Up => Up] \n[Arrow Down => Down]", textX, playerTwoTextY, textWidth, textHeight);

    fill(255, 255, 255);
    text("Press ENTER to Start!", textX, startTextY, textWidth, textHeight);
  }
}
