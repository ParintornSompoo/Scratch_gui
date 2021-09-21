class Box {
  float x,y,w,h;
  String type;
  Box(float x_, float y_, float w_, float h_, String type_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    type = type_;
  }
  boolean inBox() {
    if ((mouseX > x) && ((x+w) > mouseX)) {
      if ((mouseY > y) && ((y+h) > mouseY)) {
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
  }
}
