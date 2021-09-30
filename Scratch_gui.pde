Menu menu;
Cat cat;
ArrayList<Box> commandBox;
PImage bin_img;
PImage run_button_img;

// ###################### Tree Manager ##############################
Tree tree ;
ArrayList<Tree> arraytree;

Tree construcIf(){
  Tree treeif = new Tree("if");
  return treeif;
}
Tree construcFor(int n, Tree child){
  Tree treefor = new Tree("for");
  for(int i=0; i<n; i++){
    treefor.addchild(child);
  }
  return treefor;
}
Tree construcWalk(String way){
  Tree treewalk = new Tree(way);
  return treewalk;
}
Tree construcRotate(String side){
  Tree treeturn = new Tree(side);
  return treeturn;
}
Tree combineTree(Tree root,Tree child){
  Tree newtree = root;
  newtree.addchild(child);
  return newtree;
}
// ##############################################################

void setup() {
  size(1500,900);
  menu = new Menu();
  arraytree = new ArrayList<Tree>();
  cat = new Cat(width*4/5,height/3,"image/ScratchCat.png");
  commandBox = new ArrayList<Box>();
  bin_img = loadImage("image/bin.png");
  run_button_img = loadImage("image/run_button.png");
}
void draw() {
  background(255);
  menu.display();
  for (int i=0;commandBox.size()>i;i++) {
    Box cB = commandBox.get(i);
    cB.display();
  }
  cat.display();
  image(bin_img, 1050, 825,75,75);
  image(run_button_img, 1050, 0,75,75);
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
      Box cB = new Box(x-60,y-30,120,30,b.type,b.command);
      commandBox.add(cB);
    }
  }
}
private ArrayList<Box> getLinkedbox(Box topbox){
  ArrayList<Box> linkedbox = new ArrayList<Box>();
  linkedbox.add(topbox);
  for(Box box : commandBox){
    if(box.x == topbox.x && box.y == topbox.y+topbox.h){
      linkedbox.addAll(getLinkedbox(box));
    }
  }
  return linkedbox;
}

void mouseDragged() {
  for (int i=0;commandBox.size()>i;i++) {
    int transitionX = mouseX - pmouseX;
    int transitionY = mouseY - pmouseY;
    Box clickedbox = commandBox.get(i);
    if (clickedbox.inBox(mouseX,mouseY)) {
      for(Box belowBox : getLinkedbox(clickedbox)){
        belowBox.x += transitionX;
        belowBox.y += transitionY;
      }
    }
    clickedbox.checkEdge();
  }
}
void mouseReleased() {

  if(mouseX>1050 && mouseX<1125 && mouseY<900 && mouseY>825){
    for (int i=0;commandBox.size()>i;i++) {
      Box cB = commandBox.get(i);
      if (cB.inBox(mouseX,mouseY)) {
        commandBox.remove(i);
      }
    }
  }
  else if(mouseX>1050 && mouseX<1125 && mouseY<75 && mouseY>0){
    
    if(commandBox.size()>0){
      for(Box b : commandBox){
        if(b.command.substring(0,1).equals("n")){
          arraytree.add(construcFor(0,null));
        }
        else if(b.command.substring(0,2).equals("if")){
          arraytree.add(construcIf());
        }
        else if (b.command.substring(0,4).equals("move")){
          arraytree.add(construcWalk(b.command));
        }
        else if(b.command.substring(0,6).equals("rotate")){
          arraytree.add(construcRotate(b.command));
        }
      }
      tree = arraytree.get(0);
      for(int i=0;commandBox.size()>i;i++){
        Box belowbox = commandBox.get(i);
        for(int j=0;commandBox.size()>j;j++){
          Box topbox = commandBox.get(j);
          if(belowbox.isBelow(topbox)){
            //println(topbox.command, "=>", belowbox.command);
            tree.addchild(arraytree.get(i));
          }
        }
      }
      cat.actualize(tree.getCommandlist());
      arraytree.clear();
      println("run");
    }
  }
  else{
    for(int i=0;commandBox.size()>i;i++){
      Box belowbox = commandBox.get(i);
      if(belowbox.inBox(mouseX,mouseY)){
        for(int j=0;commandBox.size()>j;j++){
          Box topbox = commandBox.get(j);
          if(belowbox.isBelow(topbox)){
            belowbox.x=topbox.x;
            belowbox.y=topbox.y+topbox.h;
          }
        }
      }
    }
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  for (Box cB:commandBox) {
    if (cB.inBox(mouseX,mouseY)) {
      if (cB.command.substring(0,2).equals("if")) {
        if (cB.child >=0) {
          cB.child += e;
        }
        if (cB.child < 0) {
          cB.child = 0;
        }
      }
      if (cB.command.substring(0,2).equals("n=")) {
        if (cB.child >=0) {
          cB.child += e;
        }
        if (cB.child < 0) {
          cB.child = 0;
        }
      }
    }
  }
}
