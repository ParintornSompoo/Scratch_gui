class Cat{
  int x,y;
  float r;
  PImage img;
  Cat(int x_, int y_,String img_path) {
    x = x_;
    y = y_;
    r = 0;
    img = loadImage(img_path);
  }
  void move(int x_, int y_){
    x += x_;
    y += y_;
    checkInBox();
  }
  void turn(float r_) {
    r += r_;
  }
  void checkInBox() {
    if (x+50 >= width) {
      x = width - 50;
    }
    if (x-50 < (width*3/4)){
      x = width*3/4 + 50;
    }
    if (y+50 >= height) {
      y = height - 50;
    }
    if (y-50 < 0) {
      y = 50;
    }
  }
  void actualize(String command){
    if(command.equals("move right 10")){
      move(10,0);
    }
    else if(command.equals("move left 10")){
      move(-10,0);
    }
    else if(command.equals("move up 10")){
      move(0,-10);
    }
    else if(command.equals("move down 10")){
      move(0,10);
    }
    else if(command.equals("rotate left 30")){
      turn(PI/6);
    }
    else if(command.equals("rotate right 30")){
      turn(-PI/6);
    }
  }
  void display() {
    drawBox();
    pushMatrix();
    translate(x,y);
    rotate(-r);
    image(img, -50, -50,100,100);
    popMatrix();
  }
  void drawBox() {
    fill(230);
    rect(width*3/4,0,width/4,height);
  }
}
