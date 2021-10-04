class Box {
  float x,y,w,h;
  String type,command;
  int child;
  Textbox textBox;
  Box(float x_, float y_, float w_, float h_, String type_,String command_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    type = type_;
    command = command_;
    child = 0;
    if (type_.equals("oneLine")) {
      textBox = new Textbox(100,2.5,20,25);
    }
    else if (type_.equals("if-else")) {
      textBox = new Textbox(100,2.5,20,25);
    }
    else if (type_.equals("loop")) {
      textBox = new Textbox(w_/2,2.5,30,25);
    }
    textBox.text = "1";
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
    if(topbox.type.equals("oneLine")){
      if ((x < top_x+0.25*w) && (x > top_x-0.25*w)) {
        if ((y>top_y+h/2) && (y<top_y+1.5*h)) { 
          return true;
        }
      }
    }
    //else if (topbox.type.equals("if-else") || topbox.type.equals("loop")){
      //if ((x-(w/4) < top_x+0.25*w) && (x-(w/4) > top_x-0.25*w)) {
      //  if ((y>top_y+h/2) && (y<top_y+1.5*h)) { 
      //    return true;
      //  }
    //  }
    //}
    else if (topbox.type.equals("if-else") || topbox.type.equals("loop")){
      if ((x < top_x+0.25*w) && (x > top_x-0.25*w)) {
        if ((y>top_y+(topbox.h*(topbox.child+1))+h/2) && (y<top_y+(1.5*h)+h/2+(topbox.h*(topbox.child+1)))) { 
          return true;
        }
      }
    }
    return false;
  }
  boolean[] checkEdge() {
    boolean[] Return = {false,false};
    if (x <= width/10) {
      x = width/10;
      Return[0] = true;
    }
    if (x+w >= width*3/4) {
      x = width*3/4 - w;
      Return[0] = true;
    }
    if (y <= 0) {
      y = 0;
      Return[1] = true;
    }
    if (y+h >= height) {
      y = height - h;
      Return[1] = true;
    }
    return Return;
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
    textAlign(LEFT);
    text(command,5,h/1.5);
    textBox.display();
    popMatrix();
  }
}
