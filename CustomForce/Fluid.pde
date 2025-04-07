class Fluid{
  PVector corner;
  int w, h;
  float density;
  color c;
  float drag;
  
  Fluid(float d){
    corner = new PVector(0, height/2);
    w = width;
    h = height;
    density = d;
    c = (#0BA0D8);
    drag = 100;
  }
  
  void display(){
    noStroke();
    fill(c);
    rect(corner.x, corner.y, w, h);
  }
  
}//class Fluid
