class Box {
  float x,y,w,h;
  String type,command;
  Box(float x_, float y_, float w_, float h_, String type_,String command_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    type = type_;
    command = command_;
  }
  boolean inBox(float x_, float y_) {
    if ((x_ >= x) && ((x+w) >= x_)) {
      if ((y_ >= y) && ((y+h) >= y_)) {
        return true;
      }
      return false;
    }
    return false;
  }
  void display() {
    if (type.equals("oneLine")) {
      fill(0, 100, 200);
    }
    else if (type.equals("if-else")) {
      fill(204, 102, 0);
    }
    else if (type.equals("loop")) {
      fill(0, 200, 100);
    }
    rect(x,y,w,h);
    fill(0);
    textSize(16);
    text(command,x,y+20);
  }
}
