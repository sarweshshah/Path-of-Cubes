/*
* oscP5 library by Andreas Schlegel
 * oscP5 website at http://www.sojamo.de/oscP5
 */
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
MotionTracking mtrack;

void setup() {
  size(512, 424);
  frameRate(120);

  // Set up our broadcast on a port Unity listens to
  oscP5 = new OscP5(this, 57131);
  myRemoteLocation = new NetAddress("127.0.0.1", 57130);
  mtrack = new MotionTracking(this);
}


void draw() {
  background(0);

  mtrack.display();
  PVector p = mtrack.getPosition();

  //Map the mouse coordinates into numbers Unity will like
  float sensorX = map(p.x, 0, 512, -1.1, 1.4);
  float sensorY = map(p.y, 0, 424, 1, 5);
  float sensorZ = map(p.z, 0, 4500, 0, 1);
  println(sensorX, sensorY, sensorZ);

  sendValue(sensorX, sensorY, sensorZ);
}

void sendValue(float x, float y, float z) {
  // Create a channel for the x coordinate
  OscMessage oscMess1 = new OscMessage("/sensorX");
  oscMess1.add(x);

  // Create a channel for the y coordinate
  OscMessage oscMess2 = new OscMessage("/sensorY");
  oscMess2.add(y);

  // Create a channel for the y coordinate
  OscMessage oscMess3 = new OscMessage("/sensorZ");
  oscMess3.add(z);

  // Send our data over to Unity!
  oscP5.send(oscMess1, myRemoteLocation); 
  oscP5.send(oscMess2, myRemoteLocation);
  oscP5.send(oscMess3, myRemoteLocation);
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = mtrack.tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP && t < 4500) {
      t +=15;
      mtrack.tracker.setThreshold(t);
    } else if (keyCode == DOWN && t > 0) {
      t -=15;
      mtrack.tracker.setThreshold(t);
    }
  }
}
