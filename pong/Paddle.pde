public class Paddle extends Component {
	private final float width = getRelativeToCanvasWidth(0.02);
	private final float height = getRelativeToCanvasHeight(0.25);

	public float getWidth() {
		return width; 
	}

	public float getHeight() {
		return height; 
	}

	public void draw() {
		rect(super.x, super.y, width, height); 
	}
}
