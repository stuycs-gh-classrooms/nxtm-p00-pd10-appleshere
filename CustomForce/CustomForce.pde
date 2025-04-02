
/* ===================================
 
 Keyboard commands:
 1: Gravity Simulation
 2: Spring Simulatioin
 3: Drag Simulation
 =: add a new node to the front of the list
 -: remove the node at the front
 SPACE: Toggle moving on/off
 g: Toggle earth gravity on/off
 
 Mouse Commands:
 mousePressed: if the mouse is over an
 orb, remove it from the list.
 =================================== */


int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;
boolean[] toggles = new boolean[4];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag"};

OrbList orbs;

void setup() {
  size(600, 600);
  orbs = new OrbList();
  orbs.populate(NUM_ORBS, true, 1);
}//setup

void draw() {
  background(255);
  displayMode();

  orbs.display();
  if (toggles[MOVING]) {
    orbs.applyForces();
    orbs.run(toggles[BOUNCE]);
  }//moving
}//draw

/*
void indivDisandMov() {
 for (int i = 0; i < indiv.length - 1; i ++) {
 PVector grav = indiv[i].getGravity(earth, GRAVITY);
 indiv[i].applyForce(grav);
 indiv[i].move(toggles[BOUNCE]);
 }
 }
 
 
 void indivPop() {
 for (int i = 0; i < indiv.length - 1; i++) {
 indiv[i] = new Orb(random(10, 60), random(10, 20), random (MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
 }
 }
 */

void mousePressed() {
  OrbNode selected = orbs.getSelected(mouseX, mouseY);
  if (selected != null) {
    orbs.removeNode(selected);
  }
}//mousePressed

void keyPressed() {
  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }
  if (key == 'g') {
    toggles[GRAVITY] = !toggles[GRAVITY];
  }
  if (key == 'b') {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (key == 'd') {
    toggles[DRAGF] = !toggles[DRAGF];
  }
  if ((key == '=' || key =='+') && orbs.type == 2) {
    orbs.addFront(new OrbNode());
  }
  if (key == '-' && orbs.type == 2) {
    orbs.removeFront();
  }
  if (key == '1') {
    orbs.populate(NUM_ORBS, true, 1);
  }
  if (key == '2') {
    orbs.populate(NUM_ORBS, false, 2);
  }
  if (key == '3') {
    orbs.populate(NUM_ORBS, false, 3);
  }
}//keyPressed


void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int spacing = 85;
  int x = 0;

  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
}//display
