

Title title;
BasketballWorld world;

bool keyEnterPressed = false;

void setup() {
  fullScreen(); //fullScreen(1); //Para pantalla secundaria
  //frameRate(60);  
  smooth();

  title = new Title();
  world = new BasketballWorld(this);
  
  setupKinect();
}


void draw() {
  background(80, 120, 200);

  drawKinect();
  world.render();
  title.render();
}


// SIMULAR CON TECLADO!!

void keyPressed() {
  if(keyCode == 18 || keyCode == 32) world.grabObject(mouseX, mouseY);
  println(keyCode);
  
  
    
  kinectConfig_keyPressed();
}

void keyReleased() {
  if(keyCode == 18 || keyCode == 32) world.releaseObject(mouseX, mouseY);
}

void mouseMoved(){
 world.dragObject(mouseX, mouseY); 
}

// EVENTOS KINECT

void kinectEntered(int kinectX, int kinectY){
  world.grabObject(kinectX, kinectY); 
}

void kinectReleased(int kinectX, int kinectY){
  world.releaseObject(kinectX, kinectY); 
}

void kinectMoved(int kinectX, int kinectY){
  world.dragObject(kinectX, kinectY); 
}
