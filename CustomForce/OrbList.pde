/*===========================
  OrbList (ALL WORK GOES HERE)

  Class to represent a Linked List of OrbNodes.

  Instance Variables:
    OrbNode front:
      The first element of the list.
      Initially, this will be null.

  Methods to work on:
    0. addFront
    1. populate
    2. display
    3. applySprings
    4. applyGravity
    5. run
    6. removeFront
    7. getSelected
    8. removeNode

  When working on these methods, make sure to
  account for null values appropraitely. When the program
  is run, no NullPointerExceptions should occur.
  =========================*/

class OrbList {

  OrbNode front;

//constructor

  /*===========================
    addFront(OrbNode o)

    Insert o to the beginning of the list.
    =========================*/
  void addFront(OrbNode o) {
    OrbNode newNode = o;
    newNode.next = front;
    if (front != null){
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
  void populate(int n, boolean ordered) {
    front = null;
    int num = n;
    if (ordered){
      for (int i = 0; i < num; i++){
        addFront(new OrbNode());
        front.center.x = SPRING_LENGTH * i;
        front.center.y = height / 2;
      }
    }
    else {
      for (int i = 0; i < num; i++){
        addFront(new OrbNode());
      }
    }      
    
  }//populate

  /*===========================
    display(int springLength)

    Display all the nodes in the list using
    the display method defined in the OrbNode class.
    =========================*/
  void display() {
    
    OrbNode current = front;
    while (current != null){
      current.display();
      current = current.next;    
    }

  }//display

  /*===========================
    applySprings(int springLength, float springK)

    Use the applySprings method in OrbNode on each
    element in the list.
    =========================*/
  void applySprings(int springLength, float springK) {
    
    OrbNode current = front;
    while (current != null){
      current.applySprings(springLength, springK);
      current = current.next;
    }
    
  }//applySprings

  /*===========================
    applyGravity(Orb other, float gConstant)

    Use the getGravity and applyForce methods
    to apply gravity crrectly.
    =========================*/
  void applyGravity(Orb other, float gConstant) {
    
    OrbNode current = front;
    while (current != null){
      current.applyForce(current.getGravity(other, gConstant));
      current = current.next;
    }
    
    
    
    
  }//applySprings
  


  /*===========================
    run(boolean bounce)

    Call run on each node in the list.
    =========================*/
  void run(boolean bounce) {
      
    OrbNode current = front;
    while (current != null){
      current.move(bounce);
      current = current.next;      
    }
    
  }//applySprings

  /*===========================
    removeFront()

    Remove the element at the front of the list, i.e.
    after this method is run, the former second element
    should now be the first (and so on).
    =========================*/
  void removeFront() {
    
    front.next.previous = null;
    front = front.next;

     
  }//removeFront


  /*===========================
    getSelected(float x, float y)

    If there is a node at (x, y), return
    a reference to that node.
    Otherwise, return null.

    See isSlected(float x, float y) in
    the Orb class (line 115).
    =========================*/
  OrbNode getSelected(int x, int y) {
   
    OrbNode current = front;
    while (current != null){
      if (current.isSelected(x,y)){
        return current;
      }
      current = current.next;
    }
    
    return null;
  }//getSelected

  /*===========================
    removeNode(OrbNode o)

    Removes o from the list. You can
    assume o is an OrbNode in the list.
    You cannot assume anything about the
    position of o in the list.
    =========================*/
  void removeNode(OrbNode o) {
         
    if (o.previous != null && o.next != null){
       o.previous.next = o.next;
       o.next.previous = o.previous;
    }   
    else if (o == front){
      o.next.previous = null;
      front = o.next;
    }
    else if (o.next == null){

      o.previous.next = null;

    }        
    o = null;    
  }
  
  
  
}//OrbList
