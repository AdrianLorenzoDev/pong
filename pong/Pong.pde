import processing.sound.*;

String title = "Pong!";

// GameController
private GameController controller;

// Key pressed registers
boolean isWPressed = false;
boolean isSPressed = false;
boolean isUpPressed = false;
boolean isDownPressed = false;
boolean hasGameStarted = false;

public void settings(){
	size(600, 600);
}

public void setup() {
	setTitle(title);
	noStroke();
	controller = new GameController(new Game());
}

public void draw() {
	background(0, 0, 0);
	controller.run();
}

void keyPressed() {
	if (key == 'w') {
		isWPressed = true;
	}
	
	if (key == 's'){
		isSPressed = true; 
	}
	
	if (key == CODED) {
		if (keyCode == UP) {
			isUpPressed = true; 
		}
		
		if (keyCode == DOWN) {
			isDownPressed = true;
		}
	}
}

void keyReleased() {
	if (key == 'w') {
		isWPressed = false;
	}

	if (key == 's'){
		isSPressed = false; 
	}

	if (key == CODED) {
		if (keyCode == UP) {
			isUpPressed = false; 
		}

		if (keyCode == DOWN) {
			isDownPressed = false;
		}
	}
}

void mouseClicked() {
  	controller.startGame();
}

public float getRelativeToCanvasWidth(float rel) {
  	return pixelWidth * rel; 
}

public float getRelativeToCanvasHeight(float rel) {
  	return pixelHeight * rel; 
}
