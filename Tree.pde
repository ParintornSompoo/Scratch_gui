class Tree
{
  // -------------------------------------------
  class Node
  {
    ArrayList<Node> children;
    String command;
    
    Node(String command_){
      children = new ArrayList<Node>();
      command = command_;
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
    
    void drawNode(int x,int y){
      fill(0);
      //circle(x, y, 50);
      textSize(20);
      text(command, x, y);
      fill(255);
    }
  }
  // -------------------------------------------
  Node root;
  
  Tree(String command){
    if(command.equals("if")){
      root = construcIftree();
    }
    else if(command.equals("for")){
      root = construcFortree();
    }
    else{
      root = new Node(command);
    }
    
  }
  // -------------------------------------------------------
  Node construcIftree(){
    Node node = new Node("if");
    Node truechild = new Node("null");
    Node falsechild = new Node("null");
    node.addchild(truechild);
    node.addchild(falsechild);
    return node;
  }
  
  Node construcFortree(){
    Node node = new Node("for");
    return node;
  }
  // -------------------------------------------------------
  void changeLastChild(Tree trees){
    Node child = trees.getRoot();
    root.changechild(child);
  }
  void changeFirstChild(Tree trees){
    Node child = trees.getRoot();
    root.changeAnychild(child,0);
  }
  void changeSecoundChild(Tree trees){
    Node child = trees.getRoot();
    root.changeAnychild(child,1);
  }
  void addIfstatement(Tree trees,String condition){
    Tree treeofif = new Tree(condition);
    treeofif.addchild(trees);
    changeFirstChild(treeofif);
  }
  void addElsestatement(Tree trees){
    changeSecoundChild(trees);
  }
  void addchild(Tree trees){
    Node child = trees.getRoot();
    root.addchild(child);
  }
  
  Node getRoot(){
    return root;
  }
  
  ArrayList<String> getCommandlist (Node root){
    ArrayList<String> commands = new ArrayList<String>();
    commands.add(root.command);
    ArrayList<Node> children = root.getchildren();
    for(int i=0; i<children.size(); i++){
      ArrayList<String> childcommandlist = getCommandlist(children.get(i));
      for(int j=0; j<childcommandlist.size();j++){
        String childcommand = childcommandlist.get(j);
        if(root.command.equals("if")){
          if(childcommand.equals("true")){
            i++;
            continue;
          }
          else if(childcommand.equals("false")){
            break;
          }
        }
        else if(childcommand.equals("if") || childcommand.equals("for") || childcommand.equals("null")){
          continue;
        }
        commands.add(childcommand);
      }
    }
    return commands;
  }
  // -------------------------------------------------------
  void draw(int w, int h,Node node){
    node.drawNode(w/2,h/10);
    ArrayList<Node> children = node.getchildren();
    for(int i=0; i<children.size(); i++){
      line(w/2,h/10,((w/children.size())*(i+1))/2,(h+1000)/10);
      draw((w/children.size())*(i+1),h+1000,children.get(i));
    }
  }
}
