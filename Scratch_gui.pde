Menu menu;
Cat cat;
ArrayList<Box> commandBox;
PImage bin_img;
PImage run_button_img;

// ###################### Tree Manager ##############################

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
Tree construcCataction(String action){
  Tree treeaction = new Tree(action);
  return treeaction;
}
Tree combineTree(Tree root,Tree child){
  Tree newtree = root;
  newtree.addchild(child);
  return newtree;
}
// ##############################################################
ArrayList<Box> linkedBox;
private ArrayList<Box> getLinkedbox(Box topbox){
  ArrayList<Box> linkedbox = new ArrayList<Box>();
  linkedbox.add(topbox);
  for(Box box : commandBox){
    if((topbox.type.equals("if-else") || topbox.type.equals("loop"))&& box.isIndent(topbox)){
      linkedbox.addAll(getLinkedbox(box));
    }
    if(box.isBelow(topbox)){
      linkedbox.addAll(getLinkedbox(box));
    }
  }
  return linkedbox;
}
private ArrayList<Integer> getIndexOfLinkedbox(int index_topbox){
  ArrayList<Integer> index_linkedbox = new ArrayList<Integer>();
  index_linkedbox.add(index_topbox);
  for(int i=0 ;i<commandBox.size();i++){
    Box box = commandBox.get(i);
    Box topbox = commandBox.get(index_topbox);
    if(box.x == topbox.x && box.y == topbox.y+topbox.h){
      index_linkedbox.addAll(getIndexOfLinkedbox(i));
    }
  }
  return index_linkedbox;
}
private int getIndexToperbox(){
  int index_topperbox = 0;
  for(int i=0;i<commandBox.size();i++){
    Box topperbox = commandBox.get(index_topperbox);
    Box tempbox = commandBox.get(i);
    if(tempbox.y<topperbox.y){
      index_topperbox = i;
    }
  }
  return index_topperbox;
}
// ###############################################################
void setup() {
  size(1500,900);
  frameRate(60);
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
  image(bin_img, 1050, 825,75,75);
  for (int i=0;commandBox.size()>i;i++) {
    Box cB = commandBox.get(i);
    cB.display();
  }
  image(run_button_img, 1050, 0,75,75);
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
      Box cB = new Box(x-60,y-30,120,30,b.type,b.command);
      commandBox.add(cB);
    }
  }
  for(Box clickedbox : commandBox){
    if (clickedbox.inBox(mouseX,mouseY)) {
      linkedBox = getLinkedbox(clickedbox);
    }
  }
  for (Box cB:commandBox) {
    cB.textBox.PRESSED(mouseX - cB.x,mouseY - cB.y);
  }
}

void mouseDragged() {
  if(linkedBox !=null){
    int transitionX = mouseX - pmouseX;
    int transitionY = mouseY - pmouseY;
    for(Box belowBox : linkedBox){
      belowBox.x += transitionX;
      belowBox.y += transitionY;
      belowBox.checkEdge();
    }
  }
}
void mouseReleased() {

  if(mouseX>1050 && mouseX<1125 && mouseY<900 && mouseY>825 && linkedBox != null){
    for (Box b : linkedBox) {
      commandBox.remove(b);
    }
  }
  else if(mouseX>1050 && mouseX<1125 && mouseY<75 && mouseY>0){
    
    if(commandBox.size()>0){
      for(Box b : commandBox){
        if(b.type.equals("loop")){
          arraytree.add(construcFor(0,null));
        }
        else if(b.type.equals("if-else")){
          arraytree.add(construcIf());
        }
        else if (b.type.equals("oneLine")){
          arraytree.add(construcCataction(b.command));
        }
      }
      
      Tree tree = new Tree("Root");
      ArrayList<Integer> index_linkedbox = getIndexOfLinkedbox(getIndexToperbox());
      for(int i : index_linkedbox){
        tree.addchild(arraytree.get(i));
      }
      cat.actualize(tree.getCommandlist());
      arraytree.clear();
    }
  }
  else{
    for(Box clickedbox : commandBox){
      if(clickedbox.inBox(mouseX,mouseY)){
        for(Box topbox : commandBox){
          if(clickedbox.isBelow(topbox)){
            if(topbox.type.equals("oneLine")){
              ArrayList<Box> linkedboxes = getLinkedbox(clickedbox);
              for(int i=0;i<linkedboxes.size();i++){
                Box belowBox = linkedboxes.get(i);
                belowBox.x = topbox.x;
                belowBox.y = topbox.y + topbox.h*(i+1);
              }
            }
            else if (topbox.type.equals("if-else") || topbox.type.equals("loop")){
              ArrayList<Box> linkedboxes = getLinkedbox(clickedbox);
              for(int i=0;i<linkedboxes.size();i++){
                Box belowBox = linkedboxes.get(i);
                belowBox.x = topbox.x;
                belowBox.y = topbox.y + (topbox.h*(topbox.child+1))+ topbox.h*(i+1);
              }
            }
          }
          else if(topbox.type.equals("if-else") || topbox.type.equals("loop")){
            if(clickedbox.isIndent(topbox)){
                ArrayList<Box> linkedboxes = getLinkedbox(clickedbox);
                for(int i=0;i<linkedboxes.size();i++){
                  Box belowBox = linkedboxes.get(i);
                  belowBox.x = topbox.x+topbox.w/4;
                  belowBox.y = topbox.y + topbox.h*(i+1);
                }
                topbox.child = linkedboxes.size();
            }
          }
        }
      }
    }
  }
  if(linkedBox != null){
    linkedBox.clear();
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  for (Box cB:commandBox) {
    if (cB.inBox(mouseX,mouseY)) {
      if (cB.type.equals("loop")) {
        int n = Integer.parseInt(cB.command.substring(2));
        if ((n-e) >=1) {
          cB.command = "n=" + (int)(n-e);
        }
        if ((n-e) < 1) {
          cB.command = "n=1";
        }
      }
    }
  }
}
void keyPressed() {
  for (Box cB:commandBox) {
    cB.textBox.KEYPRESSED(key, (int)keyCode);
  }
}
