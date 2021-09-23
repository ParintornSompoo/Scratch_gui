class Cat{
  int x,y;
  float r;
  Cat(int x_, int y_) {
    x = x_;
    y = y_;
    r = 0;
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
  void display() {
    drawBox();
    translate(x,y);
    rotate(-r);
    image(img, -50, -50,100,100);
  }
  void drawBox() {
    fill(230);
    rect(width*3/4,0,width/4,height);
  }
}
