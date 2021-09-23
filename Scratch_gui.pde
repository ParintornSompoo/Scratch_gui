Menu menu;
Cat cat;
PImage img;
ArrayList<Box> commandBox;
void setup() {
  size(1500,900);
  menu = new Menu();
  cat = new Cat(width*4/5,height/3);
  commandBox = new ArrayList<Box>();
  img = loadImage("ScratchCat.png");
}
void draw() {
  background(255);
  menu.display();
  for (int i=0;commandBox.size()>i;i++) {
    Box cB = commandBox.get(i);
    cB.display();
  }
  cat.display();
}
void mousePressed() {
  for (int i=0;menu.boxes.size()>i;i++) {
    Box b = menu.boxes.get(i);
    if (b.inBox(mouseX,mouseY)) {
      int x = width/2;
      int y = height*1/4;
      for (int j=0;commandBox.size()>j;j++) {
        Box cB = commandBox.get(j);
        if (cB.inBox(x,y)) {
          y += 45;
        }
      }
      Box cB = new Box(x-60,y-30,120,30,"oneLine");
      commandBox.add(cB);
    }
  }
}
void mouseDragged() {
  for (int i=0;commandBox.size()>i;i++) {
    Box cB = commandBox.get(i);
    if (cB.inBox(mouseX,mouseY)) {
      cB.x += mouseX - pmouseX;
      cB.y += mouseY - pmouseY;
    }
  }
}
