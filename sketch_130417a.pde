PImage myImage;

void setup(){
  
 String url = "https://www.cia.gov/library/publications/the-world-factbook/graphics/flags/large/us-lgflag.gif";
   
 myImage = loadImage(url, "gif");
   
 // resize image to 72 pixels high
 myImage.resize(72, 0);

 // find real width and height
 int real_width = myImage.width;
 int real_height = myImage.height;

 // scale canvas
 size(real_width, real_height);

 noLoop(); 
}

void draw(){
    
  image(myImage, 0, 0);
  
  loadPixels();
  
  //iterate through each pixel -- grid below
  // 3x3 grid
  // 0 1  2  3
  // 4 5  6  7
  // 8 9 10 11
  
  // location of the pixel based on grid above
  int loc = 0;
  
  for (int y_pos=0;  y_pos<height; y_pos++){ 
    for (int x_pos=0; x_pos < width; x_pos++){
      loc = x_pos + y_pos*width;
      pixels[loc] = pixels[loc];
      // print out each position
      println("(" + x_pos + "," + y_pos + ") r " + red(pixels[loc])+ " g " + green(pixels[loc]) + " b " + blue(pixels[loc]));
    }
  }

  
  println("width " + width);
  println("height " + height);
  
  // if height is > 72, scale down first
  // if width is > 432, scale down second

  
  updatePixels();
}
