float camX, camY;
int numBacteria = 10, eaten = -1;
float mult = 0.5;
boolean ate;
Food food = new Food(0, 0, 0, 0);
class Food {
  int x, y, z, count, eatCounter;
  float rot;
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
    popMatrix();
    pushMatrix();
    rot += PI/50;
    translate(this.x, this.y-20/((eatCounter/3)+1)-10, this.z);
    rotateY(rot);
    //textAlign(CENTER);
    text(eaten, 0, 0);
    popMatrix();
  }
  void checkEat() {
    eatCounter = 0;
    for(int i = 0; i < bacteria.length; i++) {
      if(bacteria[i].eating) {eatCounter++;}
    }
    if(eatCounter == bacteria.length) {
      this.x = (int) (Math.random()*800);
      this.y = (int) (Math.random()*800);
      this.z = (int) (Math.random()*800-400);
      for(int i = 0; i < numBacteria; i++) {
        bacteria[i].x += Math.random()*100-50;
        bacteria[i].y += Math.random()*100-50;
        bacteria[i].z += Math.random()*100-50;
      }
      ate = true;
    }
  }
  void moveCam() {
    camX += (food.x-camX)/5;
    camY += (food.y-camY)/5;
  }
}

class Bacteria {
  int col;
  float x, y, z, disX, disY, disZ;
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
    disX = this.x-food.x;
    disY = this.y-food.y;
    disZ = this.z-food.z;
    rotateX((float) (Math.atan(-disZ/disY)));
    rotateY((float) (Math.atan2(disX, disZ))+PI);
    bacteriaShape(mult, this.col);
    popMatrix();
  }
  void walk() {
    this.x += Math.random()*(food.x-this.x)/10-(food.x-this.x)/25;
    this.y += Math.random()*(food.y-this.y)/10-(food.y-this.y)/25;
    this.z += Math.random()*(food.z-this.z)/10-(food.z-this.z)/25;
    if(Math.abs(disX) <= 30  && Math.abs(disY) <= 30 && Math.abs(disZ) <= 20) {
      this.eating = true;
    } else {
      this.eating = false;
    }
  }
}
Bacteria[] bacteria = new Bacteria[numBacteria];

void setup() {
  //fullScreen(P3D);
  size(1000, 1000, P3D);
  //textAlign(CENTER);
  textSize(40);
  for(int i = 0; i < numBacteria; i++) {bacteria[i] = new Bacteria(width/2, height/2, 0, color((int) (Math.random()*205+50), (int) (Math.random()*205+50), (int) (Math.random()*205+50)), false);}
}

void draw() {
 background(100);
 lights();
 if(!mousePressed) {food.moveCam();}
 camera(width/2.0, height/2.0, height/2.0/tan(PI*30.0/180.0), camX, camY, 0, 0, 1.0, 0);
 food.checkEat();
 food.show();
 for(int i = 0; i < bacteria.length; i++) {
   bacteria[i].walk();
   bacteria[i].show();
 }
   if(ate) {
    for(int i = 0; i < bacteria.length; i++) {bacteria[i].eating = false;}
    ate = false;
    eaten++;
    }
 if(eaten >= 5) {
    eaten = -1;
    numBacteria *= 1.5;
    bacteria = new Bacteria[numBacteria];
    for(int i = 0; i < numBacteria; i++) {bacteria[i] = new Bacteria(width/2, height/2, 0, color((int) (Math.random()*205+50), (int) (Math.random()*205+50), (int) (Math.random()*205+50)), false);}
 }
}

void mouseDragged() {
  camX += -(mouseX-pmouseX);
  camY += -(mouseY-pmouseY);
}

void bacteriaShape(float mult, int bactCol) {
  noStroke();
  fill(bactCol);
  sphere(20*mult);
  pushMatrix();
  fill(255);
  translate(7*mult, -5*mult, 10*mult);
  sphere(10*mult);
  translate(-14*mult, 0, 0);
  sphere(10*mult);
  popMatrix();
  pushMatrix();
  fill(0);
  translate(8*mult, -5*mult, 16*mult);
  sphere(5*mult);
  translate(-16*mult, 0, 0);
  sphere(5*mult);
  popMatrix();
  pushMatrix();
  stroke(0);
  strokeWeight(mult);
  fill(255);
  translate(0, 8*mult, 15*mult);
  rotateX(QUARTER_PI);
  box(10*mult, 5*mult, 5*mult);
  popMatrix();
  noStroke();
}
