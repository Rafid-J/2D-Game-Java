class Enemy extends EnemyBase {

  PImage[] frames;
  int frame = 0;
  int frameDelay = 0;
  int frameDelayMax = 7;
  float offsetX, offsetY;

  Enemy(float x, float y) {
    super(x, y, 50);

    offsetX = random(-40, 40);
    offsetY = random(-25, 25);

    frames = new PImage[3];
    frames[0] = loadImage("ship.png");
    frames[1] = loadImage("shipright.png");
    frames[2] = loadImage("shipleft.png");
  }

  // REQUIRED by abstract class
  @Override
  void move(Treasure goal) {
    float targetX = goal.x + offsetX;
    float targetY = goal.y + offsetY;

    if (x < targetX) x += speed;
    else if (x > targetX) x -= speed;

    if (y < targetY) y += speed;
    else if (y > targetY) y -= speed;
  }

  // REQUIRED by abstract class
  @Override
  void display() {
    image(frames[frame], x, y, size, size);

    frameDelay++;
    if (frameDelay >= frameDelayMax) {
      frameDelay = 0;
      frame = (frame + 1) % frames.length;
    }
  }
}
