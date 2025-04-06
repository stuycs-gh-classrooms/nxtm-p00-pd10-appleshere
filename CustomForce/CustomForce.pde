

/* ===================================
 
 Keyboard commands:
' ': movement on/off
'b': wall bouncing on/off
'1': Setup simulation 1 (orbital gravity)
'2': Setup simulation 2 (spring)
'3': Setup simulation 3 (drag)
'3': Setup simulation 4 (custom)
'3': Setup simulation 5 (combination)

 =================================== */


int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
PVector ARTI_GRAV = new PVector(0, 1);
float G_CONSTANT = 1;
float D_COEF = 100;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;
int SPRINGS = 4;
int CUSTOMS = 5;
int MIX = 6;
boolean[] toggles = new boolean[7];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag", "Springs", "Custom", "Mix"};

FixedOrb earth;
OrbList orbs;

void setup() {
  
  size(600, 600);
  orbs = new OrbList();
  orbs.populate(NUM_ORBS, true, 1);
  earth = new FixedOrb (width/2, height/2, 50, 100);
}//setup

void draw() {
  background(255);
  displayMode();
   
    fill (255);
    rect(0, 25, width, height);
    if(toggles[DRAGF]|| toggles[MIX]){
      fill(204, 229, 255);
      rect(0, 20, width/2, height);
    }
    
  
  if (toggles[GRAVITY] || toggles[DRAGF] || toggles[SPRINGS] || toggles[CUSTOMS] || toggles[MIX]){
    orbs.display();
    if (toggles[MOVING]) {
      orbs.applyForces();
      orbs.run(toggles[BOUNCE]);
    }//moving
    if (toggles[MIX]){
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
  if (toggles[GRAVITY] || toggles[DRAGF] || toggles[SPRINGS] || toggles[CUSTOMS] || toggles[MIX]){
    bou = true;
  }
  else { bou = false; }
  
  
  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }
  if (key == '1' && !toggles[DRAGF] && !toggles[SPRINGS] && !toggles[MIX]) {
    toggles[GRAVITY] = !toggles[GRAVITY];
    orbs.populate(NUM_ORBS, true, 1);

  }
  if (key == 'b' && bou) {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (key == '3' && !toggles[GRAVITY] && !toggles[SPRINGS] && !toggles[MIX]) {
    toggles[DRAGF] = !toggles[DRAGF];
    orbs.populate(NUM_ORBS, false, 3);
        
  }
  if (key == '5'){
    // springs, orbital gravity, and drag
    toggles[MIX] = !toggles[MIX];
    orbs.populate(NUM_ORBS, false, 2);     
  }



  if (key == '2' && !toggles[DRAGF] && !toggles[GRAVITY]) {
    toggles[SPRINGS] = !toggles[SPRINGS];
      if (toggles[SPRINGS]){
        orbs.populate(NUM_ORBS, false, 2);
      }
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
