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
      textBox = new Textbox(82,2.5,37,25,3);
      textBox.text = "1";
    }
    else if (type_.equals("loop")) {
      textBox = new Textbox(40,2.5,37,25,3);
      textBox.text = "1";
    }
    else{
      textBox = new Textbox(0,0,0,0,0);
    }
    
  }
  void drag(){
  int trans_x = mouseX - pmouseX;
  int trans_y = mouseY - pmouseY;
    x += trans_x;
    y += trans_y;
  }
  void connectBelow(Box topbox){
    float posy = topbox.y+topbox.h;
    if(topbox.type.equals("if-else") || topbox.type.equals("loop")){
      posy += topbox.h*(topbox.child+1);
    }
    x = topbox.x;
    y = posy;
  }
  void connectIndent(Box topbox){
    float posx = topbox.x+topbox.w/4;
    float posy = topbox.y+topbox.h;
    x = posx;
    y = posy;
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
    else if (topbox.type.equals("if-else") || topbox.type.equals("loop")){
      if ((x < top_x+0.25*w) && (x > top_x-0.25*w)) {
        if ((y>top_y+(topbox.h*(topbox.child+1))+h/2) && (y<top_y+(1.5*h)+h/2+(topbox.h*(topbox.child+1)))) { 
          return true;
        }
      }
    }
    return false;
  }
  boolean isIndent(Box topbox){
    if((x-(w/4) < topbox.x+0.25*w) && (x-(w/4) > topbox.x-0.25*w)){
      if((y>topbox.y+h/2) && (y<topbox.y+1.5*h)){
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
    if (y <= 0) {
      y = 0;
    }
    if (y+h >= height) {
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
    textAlign(LEFT);
    text(command,5,h/1.5);
    if(type.equals("oneLine") || type.equals("loop")){
      textBox.display();
    }
    popMatrix();
  }
}
