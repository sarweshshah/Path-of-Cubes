class KinectTracker {

  // Depth threshold
  int threshold = 1245;

  // Raw location
  PVector loc;

  // Interpolated location
  PVector lerpedLoc;

  // Depth data
  int[] depth;

  // What we'll show the user
  PImage display;

  //Kinect2 class
  Kinect2 kinect2;

  KinectTracker(PApplet pa) {

    //enable Kinect2
    kinect2 = new Kinect2(pa);
    kinect2.initDepth();
    kinect2.initDevice();

    // Make a blank image
    display = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);

    // Set up the vectors
    loc = new PVector(0, 0, 0);
    lerpedLoc = new PVector(0, 0, 0);
  }

  void track() {
    // Get the raw depth as array of integers
    depth = kinect2.getRawDepth();

    // Being overly cautious here
    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float sumZ = 0;
    float count = 0;

    for (int x = 0; x < kinect2.depthWidth; x++) {
      for (int y = 0; y < kinect2.depthHeight; y++) {
        // Mirroring the image
        int offset = kinect2.depthWidth - x - 1 + y * kinect2.depthWidth;
        // Grabbing the raw depth
        int rawDepth = depth[offset];

        // Testing against threshold
        if (rawDepth > 0 && rawDepth < threshold) {
          sumX += x;
          sumY += y;
          sumZ += rawDepth;
          count++;
        }
      }
    }
    
    // As long as we found something
    float avgX = sumX/count;
    float avgY = sumY/count;
    float avgZ = sumZ/count;
    if (count != 0) {
      loc = new PVector(avgX, avgY, avgZ);
    }

    // Interpolating the location, doing it arbitrarily for now
    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.1f);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.1f);
    lerpedLoc.z = PApplet.lerp(lerpedLoc.z, loc.z, 0.1f);
  }

  PVector getLerpedPos() {
    return lerpedLoc;
  }

  PVector getPos() {
    return loc;
  }

  void display() {
    //PImage img = kinect2.getDepthImage();
    PImage irImage = kinect2.getIrImage();

    // Being overly cautious here
    if (depth == null || irImage == null) return;

    // Going to rewrite the depth image to show which pixels are in threshold
    // A lot of this is redundant, but this is just for demonstration purposes
    display.loadPixels();
    for (int x = 0; x < kinect2.depthWidth; x++) {
      for (int y = 0; y < kinect2.depthHeight; y++) {
        // mirroring image
        int offset = (kinect2.depthWidth - x - 1) + y * kinect2.depthWidth;

        // Raw depth
        int rawDepth = depth[offset];
        int pix = x + y * display.width;
        if (rawDepth > 0 && rawDepth < threshold) {
          // A red color instead
          display.pixels[pix] = color(150, 50, 50);
        } else {
          display.pixels[pix] = irImage.pixels[offset];
        }
      }
    }
    display.updatePixels();

    // Draw the image
    image(display, 0, 0);
  }

  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}
