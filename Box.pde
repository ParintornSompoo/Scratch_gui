class Box {
  float x,y,w,h;
  String type,command;
  int child;
  Box(float x_, float y_, float w_, float h_, String type_,String command_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    type = type_;
    command = command_;
    child = 0;
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
  boolean isBelow(Box topbox) {
    float top_x = topbox.x;
    float top_y = topbox.y;
    if ((x < top_x+0.25*w) && (x > top_x-0.25*w)) {
      if ((y>top_y+h/2) && (y<top_y+1.5*h)) { 
        return true;
      }
    }
    return false;
  }
  void checkEdge() {
    if (x <= width/10) {
      x = width/10;
    }
    if (x+w >= width*3/4) {
      x = width*3/4 - w;
    }
    if (y < 0) {
      y = 0;
    }
    if (y+h > height) {
      y = height - h;
    }
  }
  void display() {
    pushMatrix();
    translate(x,y);
    if (type.equals("oneLine")) {
      fill(0, 100, 200);
    }
    else if (type.equals("if-else")) {
      fill(204, 102, 0);
      if (command.length() > 9) {
        rect(0,h*(child+2),w,h);
        rect(0,0,w/4,h*(child+3));
      }
      else {
        rect(0,0,w/4,h*(child+2));
      }
    }
    else if (type.equals("loop")) {
      fill(0, 200, 100);
      rect(0,0,w/4,h*(child+2));
    }
    rect(0,0,w,h);
    fill(0);
    textSize(14);
    int l = command.length();
    text(command,(w-l*8)/2,20);
    popMatrix();
  }
}
