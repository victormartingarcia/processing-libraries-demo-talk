import fisica.*;

class BasketballWorld{
  
  PApplet mainSketch;
  FWorld world;
  boolean dragging = false;

  BasketballWorld(PApplet mainSketch){
   Fisica.init(mainSketch);
   
   this.mainSketch = mainSketch;

    world = new FWorld();
    world.setEdges();
    world.remove(world.top);
    world.setGravity(0, 2000);
    
    createBasket();
  }
  
  void createBasket(){
    FBox leftBox = new FBox(40, mainSketch.height/2);
    leftBox.setStroke(0);
    leftBox.setStrokeWeight(2);
    leftBox.setFill(255);
    leftBox.setStatic(true);
    leftBox.setPosition(200+leftBox.getWidth()/2, mainSketch.height/2 + leftBox.getHeight()/2);
    
    FBox rightBox = new FBox(40, mainSketch.height/2);
    rightBox.setStroke(0);
    rightBox.setStrokeWeight(2);
    rightBox.setFill(255);
    rightBox.setStatic(true);
    rightBox.setPosition(200+mainSketch.width/10 + rightBox.getWidth()/2, mainSketch.height/2 + rightBox.getHeight()/2);
    
    
    world.add(leftBox);
    world.add(rightBox);
  }
  
   void render() {
    world.step();
    world.draw();
  }

  void grabObject(int x, int y){
    if(!dragging){
      if(world.getBodies(x,y,false).size() == 0){
       //Creamos una pelota
       FCircle b = new FCircle(40);
     
       b.setStroke(0);
       b.setStrokeWeight(2);
       b.setFill(255);
       
       b.setRestitution(0.6);
       b.setPosition(x,y);
       
       world.add(b);
       world.step();
     }
     
     world.grabBody(x, y);
     dragging = true;
    } //<>// //<>//
  }
  
  void dragObject(int x, int y){
    if(dragging){
      world.dragBody(x, y); 
    }
  }
  
  void releaseObject(int x, int y){
    if(dragging){
      world.releaseBody();
      dragging = false;
    }
  }
    
}
