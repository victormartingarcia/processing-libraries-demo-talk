// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

class KinectTracker {

  Kinect kinect;

  // Depth threshold
  int threshold = 745;

  // Raw location
  PVector loc;

  // Interpolated location
  PVector lerpedLoc;
  boolean objectIsDetected;

  // Depth data
  int[] depth;
  
  // What we'll show the user
  PImage display;
  PImage biggerImage;

  KinectTracker(Kinect kinect) {
    this.kinect = kinect;

    // This is an awkard use of a global variable here
    // But doing it this way for simplicity
    kinect.initDepth();
    kinect.initVideo();
    kinect.enableMirror(true);

    // IR
    kinect.enableIR(false);
    
    // Make a blank image
    display = createImage(kinect.width, kinect.height, RGB);
    // Set up the vectors
    loc = new PVector(0, 0);
    lerpedLoc = new PVector(0, 0);
    objectIsDetected = false;
  }

  void track() {
    // Get the raw depth as array of integers
    depth = kinect.getRawDepth();

    // Being overly cautious here
    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float count = 0;

    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        
        int offset =  x + y*kinect.width;
        // Grabbing the raw depth
        int rawDepth = depth[offset];

        // Testing against threshold
        if (rawDepth < threshold) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    // As long as we found something
    if (count != 0) {
      loc = new PVector(sumX/count, sumY/count);
      // Interpolating the location, doing it arbitrarily for now
      lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
      lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
      objectIsDetected=true;
    }else{
      // Interpolating the location, doing it arbitrarily for now
      objectIsDetected=false;
    }

    
  }

  PVector getLerpedPos() {
    return lerpedLoc;
  }
  boolean isObjectDetected(){
    return objectIsDetected; 
  }

  PVector getPos() {
    return loc;
  }

  void display() {
    if ((frameCount % 3) == 1) {
      PImage imgVideo = kinect.getVideoImage();
      PImage img = kinect.getDepthImage();
  
      // Being overly cautious here
      if (depth == null || img == null) return;
  
      // Going to rewrite the depth image to show which pixels are in threshold
      // A lot of this is redundant, but this is just for demonstration purposes
      display.loadPixels();
      for (int x = 0; x < kinect.width; x++) {
        for (int y = 0; y < kinect.height; y++) {
  
          int offset = x + y * kinect.width;
          // Raw depth
          int rawDepth = depth[offset];
          int pix = x + y * display.width;
          if (rawDepth < threshold) {
            // A red color instead
            display.pixels[pix] = color(255, 50, 50, 200);
          } else {
            // No mostramos la profundidad no detectada
            display.pixels[pix] = imgVideo.pixels[offset];//color(0,0,0); //imgVideo.pixels[offset];
          }
        }
      }
      display.updatePixels();
  
  
      biggerImage = display.copy();
      biggerImage.resize(display.width*2,0);
    }
    
    image(biggerImage, width-biggerImage.width-2, height-biggerImage.height-2);

  }

  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}
