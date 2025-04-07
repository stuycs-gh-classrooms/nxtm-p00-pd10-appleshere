

/* ===================================
 
 Keyboard commands:
 ' ': movement on/off
 'b': wall bouncing on/off
 '1': Setup simulation 1 (orbital gravity)
 '2': Setup simulation 2 (spring)
 '3': Setup simulation 3 (drag)
 '4': Setup simulation 4 (custom)
 '5' Setup simulation 5 (combination)
 
 Don't forget to deselect each simulation before beginning another one
 
 =================================== */


int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
PVector ARTI_GRAV = new PVector(0, 0);
PVector WIND = new PVector(0, 0);
float G_CONSTANT = 1;
float D_COEF = 2;
float WATER_DENSITY = 1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;
int SPRINGS = 4;
int BUOYANT = 5;
int MIX = 6;
boolean[] toggles = new boolean[7];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag", "Springs", "Bouyant", "Mix"};

FixedOrb earth;
Fluid water;
OrbList orbs;

void setup() {

  size(600, 600);
  orbs = new OrbList();
  earth = new FixedOrb (width/2, height/2, 10, 5);
}//setup

void draw() {
  background(255);

  fill (255);
  noStroke();
  if (toggles[DRAGF] || toggles[MIX]) {
    fill(204, 229, 255);
    rect(0, 40, width/2, height);
  }
  displayMode();


  if (toggles[GRAVITY] || toggles[DRAGF] || toggles[SPRINGS] || toggles[BUOYANT] || toggles[MIX]) {
    if (toggles[BUOYANT]) {
      water.display();
    }
    orbs.display();
    if (toggles[MOVING]) {
      orbs.applyForces();
      orbs.run(toggles[BOUNCE]);
    }//moving
    if (toggles[MIX]) {
      earth.display();
    }
  }
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



void keyPressed() {
  boolean bou;
  if (toggles[GRAVITY] || toggles[DRAGF] || toggles[SPRINGS] || toggles[BUOYANT] || toggles[MIX]) {
    bou = true;
  } else {
    bou = false;
  }


  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }
  if (key == '1' && !toggles[DRAGF] && !toggles[SPRINGS] && !toggles[MIX] && !toggles[BUOYANT]) {
    toggles[GRAVITY] = !toggles[GRAVITY];
    orbs.populate(NUM_ORBS, true, 1);
    ARTI_GRAV.y = 0;
    WIND.x = 0;
  }
  if (key == 'b' && bou) {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (key == '3' && !toggles[GRAVITY] && !toggles[SPRINGS] && !toggles[MIX] && !toggles[BUOYANT]) {
    toggles[DRAGF] = !toggles[DRAGF];
    orbs.populate(NUM_ORBS, false, 3);
  }
  if (key == '4' &&!toggles[GRAVITY] && !toggles[SPRINGS] && !toggles[MIX] && !toggles[DRAGF] ) {
    toggles[BUOYANT] = !toggles[BUOYANT];
    toggles[BOUNCE] = true;
    water = new Fluid(WATER_DENSITY);
    orbs.populate(3, false, 4);
  }
  if (key == '5' && !toggles[DRAGF] && !toggles[GRAVITY] && !toggles[BUOYANT] && !toggles[SPRINGS]) {
    // springs, orbital gravity, and drag
    toggles[MIX] = !toggles[MIX];
    orbs.populate(NUM_ORBS, false, 2);
    ARTI_GRAV.y = 0;
    WIND.x = 0;
  }
  if(keyCode == UP){
    ARTI_GRAV.y -= 0.01;
  }
  if(keyCode == DOWN){
    ARTI_GRAV.y += 0.01;
  }
  if(keyCode == LEFT){
    WIND.x -= 0.1;
  }
  if(keyCode == RIGHT){
    WIND.x += 0.1;
  }



  if (key == '2' && !toggles[DRAGF] && !toggles[GRAVITY] && !toggles[MIX] && !toggles[BUOYANT]) {
    toggles[SPRINGS] = !toggles[SPRINGS];
    if (toggles[SPRINGS]) {
      orbs.populate(NUM_ORBS, false, 2);
    }
  }
}//keyPressed


void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int x = 0;

  for (int m=0; m<toggles.length; m++) {
    stroke(0);
    line(0, 40, width, 40);
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
  if (orbs.type == 1) {
    text("SIM: ORBITAL GRAVITY", 0, 22);
  } else if (orbs.type == 2) {
    text("SIM: SPRINGS", 0, 22);
  } else if (orbs.type == 3) {
    text("SIM: DRAG", 0, 22);
  } else if (orbs.type == 4) {
    text("SIM: BUOYANT", 0, 22);
  } else if (orbs.type == 5) {
    text("SIM: COMBINATION", 0, 22);
  }

  text("ARTI GRAV: " + ARTI_GRAV.y, width/3, 22);
  text("WIND: " + WIND.x, 2*width/3, 22);
}//display
