Menu menu;
ArrayList<Box> commandBox;
void setup() {
  size(800,600);
  menu = new Menu();
  commandBox = new ArrayList<Box>();
}
void draw() {
  background(255);
  menu.display();
  for (int i=0;commandBox.size()>i;i++) {
    Box cB = commandBox.get(i);
    cB.display();
  }
}
void mousePressed() {
  for (int i=0;menu.boxes.size()>i;i++) {
    Box b = menu.boxes.get(i);
    if (b.inBox()) {
      Box cB = new Box(mouseX,mouseY,120,30,"oneLine");
      commandBox.add(cB);
    }
  }
}
void mouseDragged() {
  
}
