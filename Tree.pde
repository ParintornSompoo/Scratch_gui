class Tree
{
  // -------------------------------------------
  class Node
  {
    ArrayList<Node> children;
    Box box;
    
    Node(Box boxnode){
      children = new ArrayList<Node>();
      box = boxnode;
    }
    
    void addchild(Node child){
      children.add(child);   
    }
    
    void changechild(Node child){
      children.set(children.size() - 1, child);
    }
    
    void changeAnychild(Node child,int index){
      children.set(index, child);
    }
    
    void removelastchild(){
      children.remove(children.size()-1);
    }
    
    ArrayList<Node> getchildren(){
      return children;
    }
    Box getBox(){
      return box;
    }
    String getBoxType(){
      return box.type;
    }
    String getBoxCommand(){
      return box.command;
    }
  }
  // -------------------------------------------
  Node root;
  
  Tree(Box box){
    root = new Node(box);
    if(box!= null ){
      if(box.type.equals("if-else")){
        //Node conditionchild = new Node(null);
        Node conditionchild;
        if(box.command.contains("true")){
          conditionchild = new Node(new Box(0,0,0,0, "true", ""));
        }
        else{
          conditionchild = new Node(new Box(0,0,0,0, "false", ""));
        }
        Node truechild = new Node(null);
        Node falsechild = new Node(null);
        root.addchild(conditionchild);
        root.addchild(truechild);
        root.addchild(falsechild);
      }
      else if(box.type.equals("loop")){
        Node action = new Node(null);
        root.addchild(action);
      }
    }
  }
  // -------------------------------------------------------
  void changeLastChild(Tree trees){
    Node child = trees.getRoot();
    root.changechild(child);
  }
  void chandeConditionChild(Tree trees){
    Node condition = trees.getRoot();
    root.changeAnychild(condition,0);
  }
  void addIfstatement(Tree trees){
    Node child = trees.getRoot();
    root.changeAnychild(child,1);
    setLinkedPosition(root,child);
  }
  void addElsestatement(Tree trees){
    Node child = trees.getRoot();
    root.changeAnychild(child,2);
  }
  void addchild(Tree trees){
    Node child = trees.getRoot();
    root.addchild(child);
    setLinkedPosition(root,child);
  }
  void addLoopchild(Tree trees){
    Node child = trees.getRoot();
    root.changeAnychild(child,0);
    setLinkedPosition(root,child);
  }
  Node getRoot(){
    return root;
  }
  Box getRootBox(){
    return root.box;
  }
  Boolean havechild(){
    ArrayList<Node> children = root.getchildren();
    if(getRootBox().type.equals("oneLine")){
      if(children.size()>0){
        return true;
      }
    }
    else if(getRootBox().type.equals("if-else")){
      if(children.size()>3){
        return true;
      }
    }
    else if(getRootBox().type.equals("loop")){
      if(children.size()>1){
        return true;
      }
    }
    return false;
  }
  ArrayList<Box> getCommandlist(){
    return travers(root);
  }
  private ArrayList<Box> travers (Node root){
    ArrayList<Box> actionlist = new ArrayList<Box>();
    ArrayList<Node> children = root.getchildren();
    Box rootbox = root.getBox();
    String roottype = root.getBoxType();
    if(roottype.equals("oneLine")){
      actionlist.add(rootbox);
      if(children.size()>0){
        actionlist.addAll(travers(children.get(children.size()-1)));
      }
    }
    else if(roottype.equals("if-else")){
      if(children.size()>=3){
        if(children.get(0).getBox() != null){
          if("true".equals(children.get(0).getBoxType()) && children.get(1).getBox() != null){
            actionlist.addAll(travers(children.get(1)));
          }
          else if("false".equals(children.get(0).getBoxType()) && children.get(2).getBox() != null){
            actionlist.addAll(travers(children.get(2)));
          }
        }
        if(children.size()>3){
          actionlist.addAll(travers(children.get(3)));
        }
      }
    }
    else if(roottype.equals("loop")){
      if(children.size()==1){
        if(children.get(0).getBox() != null){
          int round = Integer.parseInt(rootbox.textBox.text);
          ArrayList<Box> inloop = travers(children.get(0));
          for(int i=0;i<round ;i++){
            actionlist.addAll(inloop);
          }
        }
      }
      if(children.size()>1){
        if(children.get(0).getBox() != null){
          int round = Integer.parseInt(rootbox.textBox.text);
          ArrayList<Box> inloop = travers(children.get(0));
          for(int i=0;i<round ;i++){
            actionlist.addAll(inloop);
          }
        }
        actionlist.addAll(travers(children.get(1)));
      }
    }
    return actionlist;
  }
  private void recursTree(Node n,String mode){
    if(n.getBox() != null){
      switch(mode) {
        case "display":
          n.getBox().checkEdge();
          n.getBox().display();
          break;
        case "drag":
          n.getBox().drag();
          break;
        default:
      }
    }
    ArrayList<Node> children = n.getchildren();
    for(Node renode : children){
      recursTree(renode,mode);
    }
  }
  void display(){
    recursTree(root,"display");
  }
  void drag(){
    recursTree(root,"drag");
  }
  private Node getChildByPosition(Node n,float posx,float posy){
    if(n.getBox() != null){
      if(n.getBox().inBox(posx,posy)){
        return n;
      }
      else if (!n.getBox().inBox(posx,posy) && n.getchildren().size()>0){
        ArrayList<Node> children = n.getchildren();
        Node renode = children.get(children.size()-1);
        return getChildByPosition(renode,posx,posy);
      }
    }
    return null;
  }
  Boolean isClicked(){
    if(root.getBox().inBox(mouseX,mouseY)){
      return true;
    }
    return false;
  }
  Node getClickedBox(){
    return getChildByPosition(root,mouseX,mouseY);
  }
  Boolean containChild(Tree tree){
    Node r = tree.getRoot();
    float posx = r.getBox().x;
    float posy = r.getBox().y;
    Node n = getChildByPosition(root,posx,posy);
    if(n!= null){ //&& !n.equals(r)
      return true;
    }
    return false;
  }

  private void removeNode(Node r,Node n){
    ArrayList<Node> children = r.getchildren();
    if(children.size()>0){
      Node child = children.get(children.size()-1);
      if(child.equals(n)){
        children.remove(n);
      }
      else{
        removeNode(child,n);
      }
    }
  }
  void removechild(Tree tree){
    Node r = tree.getRoot();
    int posx = (int)r.getBox().x;
    int posy = (int)r.getBox().y;
    Node n = getChildByPosition(root,posx,posy);
    removeNode(root,n);
  }
  void setLinkedPosition(Node top,Node below){
    if(below.getBox()!=null){
      ArrayList<Node> topchildren = top.getchildren();
      ArrayList<Node> belowchildren = below.getchildren();
      Box topbox = top.getBox();
      Box belowbox = below.getBox();
      if(topbox.type.equals("oneLine") || topbox.type.equals("if-else")){
        if(below.equals(topchildren.get(topchildren.size()-1))){
          belowbox.connectBelow(topbox);
        }
        else if(below.equals(topchildren.get(1))){
          belowbox.connectIndent(topbox);
        }
      }
      else if(topbox.type.equals("loop")){
        if(below.equals(topchildren.get(0))){
          belowbox.connectIndent(topbox);
        }
        if(topchildren.size() >1 && below.equals(topchildren.get(1))){
          belowbox.connectBelow(topbox);
        }
      }
      if(belowchildren.size()>0){
        setLinkedPosition(below,belowchildren.get(belowchildren.size()-1));
        if(belowchildren.size()>=3){
          setLinkedPosition(below,belowchildren.get(1));
        }
        else if(belowchildren.size()>=2){
          setLinkedPosition(below,belowchildren.get(0));
        }
      }
    }
  }
}
