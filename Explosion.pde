class Explosion {
  // data members
  float x, y;
  PImage explosionImg;
  int currentFrame = 0;
  int frameDelay = 0;
  boolean finished = false;
  
  // constructor - loads the explosion image
  Explosion(float x, float y) {
    this.x = x;
    this.y = y;
    explosionImg = loadImage("frames.png"); // your explosion image
  }
  
  // update the explosion animation each frame
  void update() {
    frameDelay++;
    // move to next frame every 5 game frames
    if (frameDelay >= 5) {
      frameDelay = 0;
      currentFrame++;
      // explosion ends after 5 frames
      if (currentFrame >= 5) {
        finished = true;
      }
    }
  }
  
  // display the explosion on screen
  void display() {
    if (!finished) {
      // explosion grows over time
      float size = 20 + currentFrame * 6;
      image(explosionImg, x - size/2, y - size/2, size, size);
    }
  }
}
