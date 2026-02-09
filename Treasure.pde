class Treasure {
  //data members
  int x, y;
  int size=90;
  PImage chest;
  // constructers
  Treasure() {
    this.x=500;
    this.y=120;
    chest=loadImage("chest.png"); //loads image from file
  }
  //other methods
  void display() {

    image(chest, x, y, size, size); //sets co ordinates of chest image
  }
}
