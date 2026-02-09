class Squid {
  // Data Members
  float x, y;
  float speed = 5;
  float size = 70;

  PImage squidImg;

  //constructors
  Squid(float x, float y) {
    squidImg = loadImage("squid.png");
    this.x = x;
    this.y = y;
  }

  //other methods
  //updates squids position to the mouse position
  void move() {
    x=mouseX; //update is stores to the mouseX position
    y=mouseY; // update is stores to the mouseY position
  }

  void display() {
    image(squidImg, mouseX, mouseY, size, size); //displays the squid
  }
}
