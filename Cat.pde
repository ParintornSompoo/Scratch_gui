class Cat{
  int x,y;
  Cat(int x_, int y_) {
    x = x_;
    y = y_;
  }
  void move(int x_, int y_){
    x += x_;
    y += y_;
    checkInBox();
  }
  void checkInBox() {
    if (x+100 >= width) {
      x = width - 100;
    }
    if (x < (width*3/4)){
      x = width*3/4;
    }
    if (y+100 >= height) {
      y = height - 100;
    }
    if (y < 0) {
      y = 0;
    }
  }
  void display() {
    drawBox();
    translate(x,y);
    image(img, 0, 0,100,100);
  }
  void drawBox() {
    fill(230);
    rect(width*3/4,0,width/4,height);
  }
}
