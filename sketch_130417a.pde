PImage myImage;

void setup(){
  
 String url = "https://www.cia.gov/library/publications/the-world-factbook/graphics/flags/large/us-lgflag.gif";
   
 myImage = loadImage(url, "gif");
 
 int real_width = myImage.width;
 int real_height = myImage.height;
 
 size(real_width, real_height);

 noLoop(); 
}

void draw(){
    
  image(myImage, 0, 0, width, height);
  
  loadPixels();
  
 /* for (int i=0; i < (width*height); i++){
    println("r " + red(pixels[i])+ " g " + green(pixels[i]) + " b " + blue(pixels[i]));
  }*/
  
  int scaled_height = 72;
  int scaled_width = (72/height)*width;
  
  myImage.resize(72, 0);
  
  //background(255);
  
  image(myImage, 0, 0);
  
  loadPixels();
  
  for (int i=0; i < (width*height); i++){
    pixels[i] = pixels[i];
    println("r " + red(pixels[i])+ " g " + green(pixels[i]) + " b " + blue(pixels[i]));
  }

  
  println("width " + width);
  println("height " + height);
  
  // if height is > 72, scale down first
  // if width is > 432, scale down second

  
  updatePixels();
}
