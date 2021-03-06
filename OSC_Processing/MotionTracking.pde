import org.openkinect.processing.*; 

class MotionTracking {

  PVector location;

  KinectTracker tracker;

  MotionTracking(PApplet pa) {
    tracker = new KinectTracker(pa);
    location = new PVector(0, 0, 0);
  }

  PVector getPosition() {
    return location;
  }

  void display() {
    background(255);

    // Run the tracking analysis
    tracker.track();
    // Show the image
    tracker.display();

    // Let's draw the raw location
    PVector v1 = tracker.getPos();
    fill(50, 100, 250, 200);
    noStroke();
    ellipse(v1.x, v1.y, 20, 20);

    // Let's draw the "lerped" location
    PVector v2 = tracker.getLerpedPos();
    fill(100, 250, 50, 200);
    noStroke();
    ellipse(v2.x, v2.y, 20, 20);

    // Display some info
    int t = tracker.getThreshold();
    fill(0);
    text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " +
      "UP increase threshold, DOWN decrease threshold", 10, 450);

    location = v2;
  }
}
