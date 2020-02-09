public class Ball extends Component {
  private final float radius = getRelativeToCanvasWidth(0.01);

  public float getRadius() {
    return radius; 
	}
 	
  public void draw() {
	  circle(super.x, super.y, radius*2);
	}
}
