/*===========================
 OrbList 
 =========================*/

class OrbList {
  int type;
  OrbNode front;
  Orb[] balls;

  //constructor

  /*===========================
   addFront(OrbNode o)
   
   Insert o to the beginning of the list.
   =========================*/
  void addFront(OrbNode o) {
    OrbNode newNode = o;
    newNode.next = front;
    if (front != null) {
      front.previous = newNode;
    }
    front = newNode;
  }//addFront


  /*===========================
   populate(int n, boolean ordered)
   
   Clear the list.
   Add n randomly generated  orbs to the list,
   using addFront.
   If ordered is true, the orbs should all
   have the same y coordinate and be spaced
   SPRING_LEGNTH apart horizontally.
   =========================*/
  void populate(int n, boolean ordered, int sim) {
    type = sim;
    if (sim == 1) {
      balls = new Orb[2];
      balls[0] = new FixedOrb(width/2, height/2, 50, 100);
      balls[1] = new Orb(width/2, height/2 + 100, 20, 10);
      balls[1].velocity = new PVector(10, 0);
    }//gravity sim setup
    if (sim == 2) {
      front = null;
      if (ordered) {
        for (int i = 0; i < n; i++) {
          addFront(new OrbNode());
          front.center.x = SPRING_LENGTH * i;
          front.center.y = height / 2;
        }
      } else {
        for (int i = 0; i < n; i++) {
          addFront(new OrbNode());
        }
      }
    }//spring sim setup
    if (type == 3) {
      balls = new Orb[n];
      for(int i = 0; i < n; i++){
        balls[i] = new Orb();
      }
    }
  }//populate

  /*===========================
   display(int springLength)
   
   Display all the nodes in the list using
   the display method defined in the OrbNode class.
   =========================*/
  void display() {
    if (type == 1 || type == 3) {
      for (int i = 0; i < balls.length; i ++) {
        balls[i].display();
      }
    }
    if (type == 2) {
      OrbNode current = front;
      while (current != null) {
        current.display();
        current = current.next;
      }
    }
  }//display

  /*===========================
   applySprings(int springLength, float springK)
   
   Use the applySprings method in OrbNode on each
   element in the list.
   =========================*/
  void applySprings(int springLength, float springK) {

    OrbNode current = front;
    while (current != null) {
      current.applySprings(springLength, springK);
      current = current.next;
    }
  }//applySprings





  /*===========================
   run(boolean bounce)
   
   Call run on each node in the list.
   =========================*/
  void run(boolean bounce) {
    for (int i = 0; i < balls.length; i ++) {
      balls[i].move(toggles[BOUNCE]);
    }
    OrbNode current = front;
    while (current != null) {
      current.move(bounce);
      current = current.next;
    }
  }//applySprings




  void applyForces() {
    if (type == 1) {
      for (int i = 1; i < balls.length; i ++) {
        PVector grav = balls[i].getGravity(balls[0], GRAVITY);
        balls[i].applyForce(grav);
      }
    }//gravity sim
    if (type == 2) {
      applySprings(SPRING_LENGTH, SPRING_K);

      if (toggles[MIX]){
          OrbNode current = front;
          while (current != null) {
            PVector grav = current.getGravity(earth, GRAVITY);
            current.applyForce(grav);
            if (current.center.x < width/2){
              PVector artidrag = (current.velocity.mult( -0.75));
              current.applyForce(artidrag);
            }                               
            current = current.next;
          }
       }        
    }//spring sim || mix sim
    
    
    if (type == 3) {
      if (toggles[DRAGF]) {
        for (int i = 0; i < balls.length; i++) {
          balls[i].applyForce(ARTI_GRAV);
          if (balls[i].center.x < width/2) {
            balls[i].applyForce(balls[i].getDragForce(D_COEF));
          }
        }
      }
    }
  }
}//OrbList
