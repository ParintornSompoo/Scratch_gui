Menu menu;
Cat cat;
PImage bin_img;
PImage run_button_img;
ArrayList<Tree> arraytree;
Tree clickedTree;

void setup() {
  size(1500,900);
  frameRate(60);
  menu = new Menu();
  cat = new Cat(width*4/5,height/3,"image/ScratchCat.png");
  arraytree = new ArrayList<Tree>();
  bin_img = loadImage("image/bin.png");
  run_button_img = loadImage("image/run_button.png");
}
void draw() {
  background(255);
  menu.display();
  image(bin_img, 1050, 825,75,75);
  for(Tree t : arraytree){
   t.display();
  }
  image(run_button_img, 1050, 0,75,75);
  cat.display();
}
void mousePressed() {
  for (Box choosenbox : menu.boxes) {
    if (choosenbox.inBox(mouseX,mouseY)) {
      int x = width/6;
      int y = height/10 + (int)(choosenbox.h * 2.25 * (arraytree.size() % 10));
      Tree tree = new Tree(new Box(x,y,120,30,choosenbox.type,choosenbox.command));
      arraytree.add(tree);
    }
  }
  for(Tree tree : arraytree){
    if(tree.isClicked()){
      clickedTree  = tree;
    }
  }
  for (Tree tree : arraytree) {
    tree.getRootBox().textBox.PRESSED(mouseX - tree.getRootBox().x,mouseY - tree.getRootBox().y);
  }
}

void mouseDragged() {
  if(clickedTree != null){
    clickedTree.drag();
    for(Tree toptree : arraytree){
      if(toptree.containChild(clickedTree)){
        toptree.removechild(clickedTree);
      }
      if(toptree.getRootBox().type.equals("if-else")){
        if(clickedTree.getRootBox().isIndent(toptree.getRootBox())){
          toptree.addIfstatement(new Tree(null));
        }
      }
    }
  }
}
void mouseReleased() {

  if(mouseX>1050 && mouseX<1125 && mouseY<900 && mouseY>825){
    ArrayList<Tree> removelist = new ArrayList<Tree>();
    for(Tree linkedtree : arraytree){
      if(clickedTree.containChild(linkedtree)){
        removelist.add(linkedtree);
      }
    }
    arraytree.remove(clickedTree);
    for(Tree removetree : removelist){
      arraytree.remove(removetree);
    }
  }
  else if(mouseX>1050 && mouseX<1125 && mouseY<75 && mouseY>0){
    // TODO actualize cat 
    if(arraytree.size()>0){
      for(Box box : arraytree.get(0).getCommandlist()){
        cat.actualize(box);
      }
    }
  }
  else{
    if(clickedTree!=null){
      for(Tree tree:arraytree){
        if(clickedTree.getRootBox().isBelow(tree.getRootBox())){
          if(!tree.containChild(clickedTree) && !tree.havechild()){
            tree.addchild(clickedTree);
          }
          break;
        }
        if(tree.getRootBox().type.equals("if-else")){
          if(clickedTree.getRootBox().isIndent(tree.getRootBox())){
            if(!tree.containChild(clickedTree)){
              tree.addIfstatement(clickedTree);
            }
            break;
          }
        }
        else if(tree.getRootBox().type.equals("loop")){
          break;
        }
      }
    }
  }
  clickedTree = null;
}
void keyPressed() {
  for (Tree tree : arraytree) {
    tree.getRootBox().textBox.KEYPRESSED(key, (int)keyCode);
  }
}
