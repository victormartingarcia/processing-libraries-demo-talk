

Title title;
BasketballWorld world;

boolean keyEnterPressed = false;

int kinectX = -1;
int kinectY = -1;

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

void keyPressed() {
  // USB powerpoint pointer release
  if(keyCode == 18){
    keyEnterPressed=true;  
    if(kinectX != -1 && kinectY != -1){
      world.grabObject(kinectX, kinectY);
    }
  }
  
  // Kinect panning and threshold
  kinectConfig_keyPressed();
}

void keyReleased() {
  // USB powerpoint pointer release
  if(keyCode == 18){
    keyEnterPressed=false;  
    world.releaseObject(kinectX, kinectY); 
  }
}

// EVENTOS KINECT

void kinectEntered(int x, int y){
  if(keyEnterPressed) world.grabObject(x, y); 
  
  updateKinectPosValues(x, y);
}

void kinectReleased(int x, int y){
  world.releaseObject(x, y); 
  
  updateKinectPosValues(x, y);
}

void kinectMoved(int x, int y){
  if(keyEnterPressed) world.dragObject(x, y); 
  
  updateKinectPosValues(x, y);
}

void updateKinectPosValues(int x, int y){
  kinectX = x;
  kinectY = y; 
}
