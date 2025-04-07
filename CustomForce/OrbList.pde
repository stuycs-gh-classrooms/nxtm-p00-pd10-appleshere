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
    if (type == 1) {
      balls = new Orb[2];
      balls[0] = new FixedOrb(width/2, height/2, 50, 100);
      balls[1] = new Orb(width/2, height/2 + 100, 20, 10);
      balls[1].velocity = new PVector(10, 0);
    }//gravity sim setup
    if (type == 2) {
      front = null;
      if (ordered) {
        for (int i = 0; i < n; i++) {
          addFront(new OrbNode());
          front.center.x = SPRING_LENGTH * i;
          front.center.y = height / 2;
        }
      } else {
        for (int i = 0; i < n; i++) {
          if (front != null){
            front.velocity = new PVector (20, 0);
          }
          addFront(new OrbNode());
        }
      }
    }//spring sim setup
    if (type == 3) {
      balls = new Orb[n];
      for (int i = 0; i < n; i++) {
        balls[i] = new Orb();
      }
      ARTI_GRAV.y = 0.01;
    }
    if (type == 4) {
      balls = new Orb[3];
      balls[0] = new Orb(width/4, 3*height/4, 20, 1000);
      balls[1] = new Orb(2*width/4, 3*height/4, 20, 400*PI);
      balls[2] = new Orb(3*width/4, 3*height/4, 20, 1500);
      ARTI_GRAV.y = 0.01;
    }
  }//populate

  /*===========================
   display(int springLength)
   
   Display all the nodes in the list using
   the display method defined in the OrbNode class.
   =========================*/
  void display() {
    if (type == 1 || type == 3 || type == 4) {
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
    if (type == 1 || type == 3 || type == 4) {
      for (int i = 0; i < balls.length; i ++) {
        balls[i].move(toggles[BOUNCE]);
      }
    }
    if (type == 2 || type == 5) {

      OrbNode current = front;
      while (current != null) {
        current.move(bounce);
        current = current.next;
      }
    }
  }//applySprings




  void applyForces() {
    if (type == 1) {
      for (int i = 1; i < balls.length; i ++) {
        balls[i].applyArtiGrav(ARTI_GRAV);
        balls[i].applyForce(WIND);
        PVector grav = balls[i].getGravity(balls[0], GRAVITY);
        balls[i].applyForce(grav);
      }
    }//gravity sim
    if (type == 2) {
      applySprings(SPRING_LENGTH, SPRING_K);
      OrbNode current = front;
      
      while (current != null && !toggles[MIX]) {
        current.applyArtiGrav(ARTI_GRAV);
        current.applyForce(WIND);
        current = current.next;
      }
      
      if (toggles[MIX]) {
        current = front;
        while (current != null) {
          PVector grav = current.getGravity(earth, G_CONSTANT);
          current.applyForce(grav);
          if (current.center.x < width/2) {
            current.applyForce(current.getDragForce(D_COEF));
          }
          current = current.next;
        }
      }
    }//spring sim || mix sim


    if (type == 3) {
      for (int i = 0; i < balls.length; i++) {
        balls[i].applyArtiGrav(ARTI_GRAV);
        balls[i].applyForce(WIND);
        if (balls[i].center.x < width/2) {
          balls[i].applyForce(balls[i].getDragForce(D_COEF));
        }
      }
    }
    if (type == 4) {
      for (int i = 0; i < balls.length; i++) {
        balls[i].applyArtiGrav(ARTI_GRAV);
        balls[i].applyForce(WIND);
        if (balls[i].center.y > water.corner.y) {
          balls[i].applyForce(balls[i].getBuoyantForce(water));
          balls[i].applyForce(balls[i].getDragForce(water.drag));
        }
      }
    }
  }
}//OrbList
