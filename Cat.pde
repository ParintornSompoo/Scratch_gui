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
  void actualize(Box b){
    int n = Integer.parseInt(b.textBox.text);
    if(b.command.equals("move right")){
      move(n,0);
    }
    else if(b.command.equals("move left")){
      move(-n,0);
    }
    else if(b.command.equals("move up")){
      move(0,-n);
    }
    else if(b.command.equals("move down")){
      move(0,n);
    }
    else if(b.command.equals("rotate left")){
      turn(radians(n));
    }
    else if(b.command.equals("rotate right")){
      turn(radians(-n));
    }
  }
  void display() {
    drawBox();
    textSize(28);
    fill(0, 0,255);
    text("x="+x+",y="+y,1200,50);
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
