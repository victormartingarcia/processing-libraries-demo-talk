
class Title{
 
  PFont font;
  
  Title(){
    font = createFont("Helvetica Bold", 60);
  }

  void render() {
    fill(255);
    textAlign(CENTER);
    textFont(font);
    text("Kinect Basketball", 50, 100, width-100, 300);
  }

}
