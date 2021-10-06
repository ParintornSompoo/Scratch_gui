class Tree
{
  // -------------------------------------------
  class Node
  {
    ArrayList<Node> children;
    String command;
    Box box;
    
    Node(Box boxnode){
      children = new ArrayList<Node>();
      box = boxnode;
      if(box == null){
        command = "null";
      }
      else{
        if(box.type.equals("oneLine")){
          command = box.command;
        }
        else if(box.type.equals("loop") || box.type.equals("if-else")){
          command = box.type;
        }
        else{
         command = "null";
        }
      }
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
    
    ArrayList<Node> getchildren(){
      return children;
    }
  }
  // -------------------------------------------
  Node root;
  
  Tree(Box box){
    root = new Node(box);
    if(box!= null ){
      if(box.type.equals("if-else")){
        Node conditionchild = new Node(null);
        Node truechild = new Node(null);
        Node falsechild = new Node(null);
        root.addchild(conditionchild);
        root.addchild(truechild);
        root.addchild(falsechild);
      }
      else if(box.type.equals("loop")){
        Node repeat = new Node(null);
        Node action = new Node(null);
        root.addchild(repeat);
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
  void addLoopchild(Tree trees,int n){
    Node child = trees.getRoot();
    for(int i =0;i<n;i++){
      root.addchild(child);
    }
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
      if(children.size()>2){
        return true;
      }
    }
    return false;
  }
  ArrayList<String> getCommandlist(){
    return travers(root);
  }
  private ArrayList<String> travers (Node root){
    ArrayList<String> commands = new ArrayList<String>();
    commands.add(root.command);
    ArrayList<Node> children = root.getchildren();
    for(int i=0; i<children.size(); i++){
      ArrayList<String> childcommandlist = travers(children.get(i));
      for(int j=0; j<childcommandlist.size();j++){
        String childcommand = childcommandlist.get(j);
        if(root.command.equals("if-else")){
          if(childcommand.equals("true")){
            i++;
            continue;
          }
          else if(childcommand.equals("false")){
            break;
          }
        }
        else if(childcommand.equals("if-else") || childcommand.equals("loop") || childcommand.equals("null")){
          continue;
        }
        commands.add(childcommand);
      }
    }
    return commands;
  }
  private void recursTree(Node n,String mode){
    if(n.box != null){
      switch(mode) {
        case "display":
          n.box.checkEdge();
          n.box.display();
          break;
        case "drag":
          n.box.drag();
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
    if(n.box!= null){
      if(n.box.inBox(posx,posy)){
        return n;
      }
      else if (!n.box.inBox(posx,posy) && n.getchildren().size()>0){
        ArrayList<Node> children = n.getchildren();
        Node renode = children.get(children.size()-1);
        return getChildByPosition(renode,posx,posy);
      }
    }
    return null;
  }
  Boolean isClicked(){
    if(root.box.inBox(mouseX,mouseY)){
      return true;
    }
    return false;
  }
  Node getClickedBox(){
    return getChildByPosition(root,mouseX,mouseY);
  }
  Boolean containChild(Tree tree){
    Node r = tree.getRoot();
    float posx = r.box.x;
    float posy = r.box.y;
    Node n = getChildByPosition(root,posx,posy);
    if(n!= null){
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
    int posx = (int)r.box.x;
    int posy = (int)r.box.y;
    Node n = getChildByPosition(root,posx,posy);
    removeNode(root,n);
  }
  void setLinkedPosition(Node r,Node n){
    ArrayList<Node> children = n.getchildren();
    ArrayList<Node> rootchild = r.getchildren();
    if(n.box!=null){
      if(n.equals(rootchild.get(rootchild.size()-1))){
        n.box.connectBelow(r.box);
        if(children.size()>0){
          setLinkedPosition(n,children.get(children.size()-1));
          if(children.size()>=3){
            setLinkedPosition(n,children.get(1));
          }
        }
      }
      else if(n.equals(rootchild.get(1))){
        n.box.connectIndent(r.box);
        if(children.size()>0){
          setLinkedPosition(n,children.get(children.size()-1));
          if(children.size()>=3){
            setLinkedPosition(n,children.get(1));
          }
        }
      }
    }
  }
}
