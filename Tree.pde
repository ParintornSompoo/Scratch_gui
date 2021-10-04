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
  }
  // -------------------------------------------
  Node root;
  
  Tree(String command){
    if(command.equals("if")){
      Node ifnode = new Node("if");
      Node conditionchild = new Node("false");
      Node truechild = new Node("null");
      Node falsechild = new Node("null");
      ifnode.addchild(conditionchild);
      ifnode.addchild(truechild);
      ifnode.addchild(falsechild);
      root = ifnode;
    }
    else if(command.equals("for")){
      root = new Node("for");
    }
    else{
      root = new Node(command);
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
  }
  void addElsestatement(Tree trees){
    Node child = trees.getRoot();
    root.changeAnychild(child,2);
  }
  void addchild(Tree trees){
    Node child = trees.getRoot();
    root.addchild(child);
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
}
