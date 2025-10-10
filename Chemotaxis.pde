float camX, camY;
int numBacteria = 10, size = 1, eaten = 0;
Food food = new Food(0, 0, 0, 0);
class Food {
  int x, y, z, count, eatCounter;
  public Food(int x, int y, int z, int eatCounter) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.eatCounter = eatCounter;
  }
  void show() {
    pushMatrix();
    fill(255, 0, 0);
    translate(this.x, this.y, this.z);
    sphere(20/((eatCounter/3)+1));
    fill(0, 200, 0);
    translate(0, -20/((eatCounter/3)+1), 0);
    box(5/((eatCounter/3)+1), 10/((eatCounter/3)+1), 5/((eatCounter/3)+1));
    translate(0, -10, 0);
    text(eaten, 0, 0);
    popMatrix();
  }
  void checkEat() {
    for(int i = 0; i < numBacteria; i++) {
      if(Math.abs(bacteria[i].x-this.x) <= 30  && Math.abs(bacteria[i].y-this.y) <= 30 && Math.abs(bacteria[i].z-this.z) <= 30 && !bacteria[i].eating) {
      }
    }
    if(eatCounter == numBacteria) {
      this.x = (int) (Math.random()*(width-20)+10);
      this.y = (int) (Math.random()*(height-20)+10);
      this.z = (int) (Math.random()*(600));
      eatCounter = 0;
      eaten++;
    }
  }
  void moveCam() {
    camX += (food.x-camX)/50;
    camY += (food.y-camY)/50;
  }
}

class Bacteria {
  int col;
  float x, y, z;
  boolean eating;
  public Bacteria(float x, float y, float z, int col, boolean eating) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.col = col;
    this.eating = eating;
  }
  void show() {
    fill(col);
    pushMatrix();
    translate(this.x, this.y, this.z);
    bacteriaShape(size, this.col);
    popMatrix();
  }
  void walk() {
    this.x += Math.random()*(food.x-this.x)/10-(food.x-this.x)/25;
    this.y += Math.random()*(food.y-this.y)/10-(food.y-this.y)/25;
    this.z += Math.random()*(food.z-this.z)/10-(food.z-this.z)/25;
    if(Math.abs(food.x-this.x) <= 30  && Math.abs(food.y-this.y) <= 30 && Math.abs(food.z-this.z) <= 30) {
      this.eating = true;
      food.eatCounter++;
    }
  }
}
Bacteria[] bacteria = new Bacteria[numBacteria];

void setup() {
  //fullScreen(P3D);
  size(1000, 1000, P3D);
  textAlign(CENTER);
  textSize(40);
  for(int i = 0; i < numBacteria; i++) {bacteria[i] = new Bacteria(width/2, height/2, 0, color((int) (Math.random()*205+50), (int) (Math.random()*205+50), (int) (Math.random()*205+50)), false);}
}

void draw() {
 background(100);
 //lights();
 for(int i = 0; i < numBacteria; i++) {
   if(!mousePressed) {food.moveCam();}
   camera(width/2.0, height/2.0, height/2.0/tan(PI*30.0/180.0), camX, camY, 0, 0, 1.0, 0);
   food.checkEat();
   food.show();
   bacteria[i].walk();
   bacteria[i].show();
 }
 if(eaten == 5) {
    eaten = 0;
    numBacteria *= 1.5;
    bacteria = new Bacteria[numBacteria];
    for(int i = 0; i < numBacteria; i++) {bacteria[i] = new Bacteria(width/2, height/2, 0, color((int) (Math.random()*205+50), (int) (Math.random()*205+50), (int) (Math.random()*205+50)), false);}
 }
}

void mouseDragged() {
  camX += -(mouseX-pmouseX);
  camY += -(mouseY-pmouseY);
}

void bacteriaShape(float size, int bactCol) {
  noStroke();
  fill(bactCol);
  sphere(20*size);
  pushMatrix();
  fill(255);
  translate(7*size, -5*size, 10*size);
  sphere(10*size);
  translate(-14*size, 0, 0);
  sphere(10*size);
  popMatrix();
  pushMatrix();
  fill(0);
  translate(8*size, -5*size, 16*size);
  sphere(5*size);
  translate(-16*size, 0, 0);
  sphere(5*size);
  popMatrix();
  pushMatrix();
  stroke(0);
  strokeWeight(size);
  fill(255);
  translate(0, 8*size, 15*size);
  rotateX(QUARTER_PI);
  box(10*size, 5*size, 5*size);
  popMatrix();
  noStroke();
}






