class Textbox {
  
  public color Background = color(230);
  public color Foreground = color(0);
  public color BackgroundSelected = color(180);
  public color Border = color(30, 30, 30);
  
  float x,y,w,h;
  int lim;
  private boolean selected = false;
  String text;
  Textbox(float x_, float y_, float w_, float h_, int lim_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = "";
    lim = lim_;
  }
  void display() {
    if (selected) {
      fill(BackgroundSelected);
    }
    else {
      fill(Background);
    }
    strokeWeight(1);
    stroke(Border);
    rect(x, y, w, h);
    fill(Foreground);
    textSize(14);
    textAlign(LEFT);
    text(text,x+5,h/1.2);
  }
  boolean KEYPRESSED(char KEY, int KEYCODE) {
    if (selected) {
      if (KEYCODE == (int)BACKSPACE) {
        backspace();
      } 
      else if (KEYCODE == 32) {
        // SPACE
        addText(' ');
      } 
      else if (KEYCODE == (int)ENTER) {
         return true;
      } 
      else {
        // CHECK IF THE KEY IS A LETTER OR A NUMBER
        boolean isKeyCapitalLetter = (KEY >= 'A' && KEY <= 'Z');
        boolean isKeySmallLetter = (KEY >= 'a' && KEY <= 'z');
        boolean isKeyNumber = (KEY >= '0' && KEY <= '9');
        if (isKeyCapitalLetter || isKeySmallLetter || isKeyNumber) {
          if (text.length() < lim) {
            addText(KEY);
          }
        }
      }
    }
    return false;
  }
  void addText(char t) {
    text += t;
  }
  void backspace() {
    if (text.length() - 1 >= 0) {
      text = text.substring(0,text.length() - 1);
    }
  }
  boolean inBox(float x_,float y_) {
    if ((x_ >= x) && ((x+w) >= x_)) {
      if ((y_ >= y) && ((y+h) >= y_)) {
        return true;
      }
    }
    return false;
  }
  void PRESSED(float x_, float y_) {
    if (inBox(x_, y_)) {
       selected = true;
    } else {
       selected = false;
    }
  }
}
