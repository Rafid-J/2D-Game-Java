class Shark extends EnemyBase {
  // data members
  PImage shark;

  // constructor
  Shark(float x, float y) {
    super(x, y, 50); // call parent constructor with size
    shark = loadImage("Shark.png");
  }

  // sharks chase the squid (player)
  void move() {
    // move toward squid position
    if (x < squid.x) {
      x += speed;
    } else if (x > squid.x) {
      x -= speed;
    }
    
    if (y < squid.y) {
      y += speed;
    } else if (y > squid.y) {
      y -= speed;
    }
  }

  // required by EnemyBase abstract class
  void move(Treasure goal) {
    move(); // use squid-chasing movement
  }

  @Override
  void display() {
    image(shark, x, y, size, size);
  }

  // boolean collision with the squid
  boolean hitsSquid(Squid s) {
    return dist(x, y, s.x, s.y) < size/2;
  }
}
