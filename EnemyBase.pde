abstract class EnemyBase {
  // data members shared by ALL enemies
  float x, y;
  float speed;
  float size;

  // constructor used by all enemy types
  EnemyBase(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    speed = random(1.5, 2.5);
  }

  // polymorphic methods – MUST be implemented by children
  abstract void move(Treasure goal);
  abstract void display();

  // shared collision logic (same for all enemies)
  boolean checkCollision(Treasure goal) {
    return x < goal.x + 90 && x + 30 > goal.x &&
           y < goal.y + 50 && y + 40 > goal.y;
  }
}
