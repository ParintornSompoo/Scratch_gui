Menu menu;
Cat cat;
PImage img;
ArrayList<Box> commandBox;
void setup() {
  size(1500,900);
  menu = new Menu();
  cat = new Cat();
  commandBox = new ArrayList<Box>();
  img = loadImage("ScratchCat.png");
}
void draw() {
  background(255);
  image(img, width*0.75, height*0.25,100,100);
  menu.display();
  cat.cat_move(5);
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
