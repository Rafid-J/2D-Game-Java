int lives = 2;              // number of lives for the treasure
int playerlife = 2;         // number of lives for the squid (main player)
boolean gameOver = false;   // game ends when playerlife reaches 0

int spawnTimer = 0;
int spawnInterval = 60;        // enemies appear every second

int score = 0;
int bestScore = 0;

// declare objects e.g player and goal
Treasure goal;
FileHandling fileHandler;
Squid squid;

// POLYMORPHISM: stores different enemy TYPES using the EnemyBase parent
ArrayList<EnemyBase> enemies = new ArrayList<EnemyBase>();
//explosion arraylist
ArrayList<Explosion> explosions = new ArrayList<Explosion>();


PImage oceanBackground;

void setup() {
  size(640, 360);

  oceanBackground = loadImage("Background.jpg");

  // Create pirates (child class objects stored as EnemyBase)
  for (int i = 0; i < 5; i++) {
    enemies.add(new Enemy(40, random(0, height - 10)));
  }

  // Create sharks (also stored in same polymorphic ArrayList)
  for (int i = 0; i < 3; i++) {
    enemies.add(new Shark(150, random(0, height)));
  }

  // Create treasure
  goal = new Treasure();

  // Create squid (player)
  squid = new Squid(width / 2, height / 2);

  // File handling for high score
  fileHandler = new FileHandling("score.txt");
  bestScore = fileHandler.loadScore();
}

void draw() {

  // GAME OVER SCREEN
  if (gameOver) {

    // Save new high score
    if (score > bestScore) {
      bestScore = score;
      fileHandler.saveScore(bestScore);
    }

    image(oceanBackground, 0, 0);

    fill(255, 0, 0);
    textSize(28);
    text("GAME OVER – YOU LOSE", width / 2 - 150, height / 2 - 20);

    fill(255);
    textSize(20);
    text("Your Score: " + score, width / 2 - 70, height / 2 + 20);
    text("Best Score: " + bestScore, width / 2 - 70, height / 2 + 50);

    return; // stop game logic
  }

  // BACKGROUND
  image(oceanBackground, 0, 0);

  // Squid movement and display
  squid.move();
  squid.display();

  // POLYMORPHIC ENEMY HANDLING - single loop for all enemy types
  for (int i = enemies.size() - 1; i >= 0; i--) {
    EnemyBase enemy = enemies.get(i);
    
    // Display all enemies (polymorphic call)
    enemy.display();
    
    // Move enemies based on type (polymorphic behavior)
    if (enemy instanceof Enemy) {
      // Pirates move toward treasure
      ((Enemy)enemy).move(goal);
    } else if (enemy instanceof Shark) {
      // Sharks use zigzag movement
      ((Shark)enemy).move();
    }
    
    // Check pirate collision with treasure
    if (enemy instanceof Enemy && enemy.checkCollision(goal)) {
      lives--;
      enemies.remove(i);
      
      if (lives <= 0) {
        gameOver = true;
      }
    }
    
    // Check shark collision with squid
    if (enemy instanceof Shark && ((Shark)enemy).hitsSquid(squid)) {
      playerlife--;
      enemies.remove(i);
      
      if (playerlife <= 0) {
        gameOver = true;
      }
    }
  }

  // Display treasure
  goal.display();


  fill(255);
  textSize(20);
  text("Treasure Lives: " + lives, 20, 30);
  text("Score: " + score, 20, 60);
  text("Squid Lives: " + playerlife, 20, 90);

  // Enemy respawn - both pirates and sharks use same timer
  spawnTimer++;
  if (spawnTimer >= spawnInterval && enemies.size() < 15) {
    // Randomly spawn either pirate or shark
    if (random(1) > 0.5) {
      enemies.add(new Enemy(0, random(height))); // Spawn pirate
    } else {
      enemies.add(new Shark(random(width), random(height))); // Spawn shark
    }
    spawnTimer = 0;
  }
// Update and display explosions
for (int i = explosions.size() - 1; i >= 0; i--) {
  Explosion explosion = explosions.get(i);
  explosion.update();
  explosion.display();
  
  if (explosion.finished) {
    explosions.remove(i); // remove finished explosions
  }
}
}

// Squid attack using mouse click - works on ALL enemy types

void mousePressed() {
  for (int i = enemies.size() - 1; i >= 0; i--) {
    EnemyBase enemy = enemies.get(i);

    if (dist(squid.x, squid.y, enemy.x, enemy.y) < 70) {
      // Create explosion at enemy position
      explosions.add(new Explosion(enemy.x, enemy.y));
      enemies.remove(i);
      score += 10;
    }
  }
}
