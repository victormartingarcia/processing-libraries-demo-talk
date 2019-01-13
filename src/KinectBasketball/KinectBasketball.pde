

Title title;
BasketballWorld world;

void setup() {
  fullScreen(); //fullScreen(1); //Para pantalla secundaria
  //frameRate(60);  
  smooth();

  title = new Title();
  world = new BasketballWorld(this);
}


void draw() {
  background(0);

  world.render();
  title.render();
}


void keyPressed() {
  if(keyCode == 18 || keyCode == 32) world.grabObject(mouseX, mouseY); 
}

void keyReleased() {
  if(keyCode == 18 || keyCode == 32) world.releaseObject(mouseX, mouseY);
}

void mouseMoved(){
 world.dragObject(mouseX, mouseY); 
}
