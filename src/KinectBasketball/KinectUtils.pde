// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/


//Muliples kinects: https://github.com/shiffman/OpenKinect-for-Processing/commit/8820b4e18d43d806df2409216d6505c0fe6da90f


import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;
boolean lastTrackedObject=false;
int lerpedPosX=-1;
int lerpedPosY=-1;

void setupKinect() {
  kinect = new Kinect(this);
  
  int numDevices = kinect.numDevices();
  println("number of Kinect v1 devices  "+numDevices);
  
  if(numDevices>0){
    kinect.activateDevice(0);
    tracker = new KinectTracker(kinect);
  }else{
    kinect = null; 
  }
}

void drawKinect() {
  
  // Rosa pixeles detectados
  fill(255, 255, 0, 200);
  noStroke();
  
  if(kinect!=null){

    // Run the tracking analysis
    tracker.track();
    // Show the image
    tracker.display();
      
    if(tracker.isObjectDetected()){
      PVector v = tracker.getLerpedPos();
      lerpedPosX = (int)(width - (2*640) - 2 + (2*v.x));
      lerpedPosY = (int)(height - (2*480) - 2 + (2*v.y));
      ellipse(lerpedPosX, lerpedPosY, 50, 50);
      

      if(!lastTrackedObject){
        kinectEntered((int)lerpedPosX, (int)lerpedPosY);
        lastTrackedObject = true; 
      }else{
        kinectMoved((int)lerpedPosX, (int)lerpedPosY);
      }
    }else{
      if(lastTrackedObject){
       kinectReleased((int)lerpedPosX, (int)lerpedPosY);
       lastTrackedObject = false;
      }
    }
    
  } 
    
}

// Adjust the threshold with key presses
void kinectConfig_keyPressed() {
  if(kinect!=null){
    int t = tracker.getThreshold();
    if (key == CODED) {
      // TILE
      float deg1 = kinect.getTilt();
      if (keyCode == UP) {
        deg1++;
      } else if (keyCode == DOWN) {
        deg1--;
      }
      deg1 = constrain(deg1, 0, 30);
      kinect.setTilt(deg1);
      
      // THRESHOLD
      if (keyCode == LEFT) {
        t+=5;
        tracker.setThreshold(t);
      } else if (keyCode == RIGHT) {
        t-=5;
        tracker.setThreshold(t);
      }
    }
  }
 
}
