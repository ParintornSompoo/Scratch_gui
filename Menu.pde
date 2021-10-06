class Menu {
  ArrayList<Box> boxes;
  Menu() {
    boxes = new ArrayList<Box>();
    String[] commandOneLine = {"move right","move left","move up","move down","rotate left","rotate right"};
    for (int i=1;commandOneLine.length>=i;i++) {
      Box b = new Box(10,25+i*40,120,30, "oneLine", commandOneLine[i-1]);
      boxes.add(b);
    }
    String[] commandIfElse = {"if (true)","if (true)-else","if (false)","if (false)-else"};
    for (int i=1;commandIfElse.length>=i;i++) {
      Box b = new Box(10,25+height/3+i*40,120,30, "if-else", commandIfElse[i-1]);
      boxes.add(b);
    }
    String[] commandLoop = {"n = "};
    for (int i=1;commandLoop.length>=i;i++) {
      Box b = new Box(10,25+height*2/3+i*40,120,30, "loop", commandLoop[i-1]);
      boxes.add(b);
    }
  }
  void display() {
    // draw menu
    fill(230);
    rect(0,0,width/10,height);
    line(0,height/3,width/10,height/3);
    line(0,height*2/3,width/10,height*2/3);
    textSize(24);
    fill(0, 100, 200);
    rect(10,10,120, 30);
    fill(204, 102, 0);
    rect(10,10+height/3,120, 30);
    fill(0, 200, 100);
    rect(10,10+height*2/3,120, 30);
    fill(0);
    text("oneLine",10,10,120, 30);
    text("if-else",10,10+height/3,120, 30);
    text("loop",10,10+height*2/3,120, 30);
    for (int i=0;boxes.size()>i;i++) {
      Box b = boxes.get(i);
      b.display();
    }
    // draw box
  }
}
