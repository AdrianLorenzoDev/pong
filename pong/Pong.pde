import processing.sound.*;
import gifAnimation.*;

// Game title
String title = "Pong!";

// GameController
private GameController controller;

// Key pressed registers
boolean isWPressed = false;
boolean isSPressed = false;
boolean isUpPressed = false;
boolean isDownPressed = false;
boolean isEnterPressed = false;
boolean hasGameStarted = false;

// Gif recording only
// GifMaker animation;
// int i = 0; 

public void settings(){
	size(600, 600);
}

public void setup() {
  surface.setTitle(title);
	noStroke();
	controller = new GameController(new Game());
  /**
  Gif recording only
  animation = new GifMaker(this, "../images/demo.gif");
  animation.setQuality(10);
  animation.setRepeat(0);
  */
}

public void draw() {
	background(0, 0, 0);
	controller.run();
  
  /**
  Gif recording only
  if (i % 3 == 0) {
    animation.addFrame();
  }
  i++;
  */
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
  	isWPressed = true;
  }
	
  if (key == 's' || key == 'S'){
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

  if (key == ENTER) {
    isEnterPressed = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
  	isWPressed = false;
  }

  if (key == 's' || key == 'S'){
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

  if (key == ENTER && key == RETURN) {
    isEnterPressed = false;
  }
}

/**
Gif recording only
void mouseClicked() {
  animation.finish();
}
*/

public float getRelativeToCanvasWidth(float rel) {
  	return pixelWidth * rel; 
}

public float getRelativeToCanvasHeight(float rel) {
  	return pixelHeight * rel; 
}
