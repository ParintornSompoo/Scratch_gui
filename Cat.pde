class Cat{
  void cat_move(int a){
    for (int i = 0;i <= a;i++){ 
        image(img, width*(0.75+(0.01*i)), height*0.25,100,100);
    }
  }
}
