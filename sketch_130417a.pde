PImage myImage;
PrintWriter output;

void setup(){
  
 // grab random internet image
 String url = "https://www.cia.gov/library/publications/the-world-factbook/graphics/flags/large/us-lgflag.gif";
   
 // load the image into processing
 myImage = loadImage(url, "gif");
   
 // resize image to 72 pixels high
 myImage.resize(72, 0);

 // find real width and height
 int real_width = myImage.width;
 int real_height = myImage.height;

 // scale canvas
 size(real_width, real_height);

 // set up file to write to -- pixels.txt
 output = createWriter("pixels.txt");

 //only run this once
 noLoop(); 
}

void draw(){
  image(myImage, 0, 0);
  
  // switches to handle monochromatic distance calculation and RGB distance calculation
  
  // monochromatic calculation -- is it closer to white or black? binary decision
  
  // RGB calculation -- is it closer to one of the eight combinations?
  // 000 - all off
  // 001 - red on
  // 010 - green on
  // 011 - red, green on
  // 100 - blue on
  // 101 - red, blue on
  // 110 - green, blue on
  // 111 - red, green, blue on
  
  int[] color_distances = new int[8];  // hold all of the color distances?
  
  // for loop to map pixels to values
  loadPixels();
  
  //iterate through each pixel -- grid below
  // 3x3 grid
  // 0 1  2  3
  // 4 5  6  7
  // 8 9 10 11
  
  // location of the pixel based on grid above
  int loc = 0;
  int ref_min_value = 450;
  int min_index = 0;
  int calculated_distance;
  
  for (int y_pos=0;  y_pos<height; y_pos++){ 
    for (int x_pos=0; x_pos < width; x_pos++){
      loc = x_pos + y_pos*width;
      for (int i=0; i<8; i++){ 
        pixels[loc] = pixels[loc];
        calculated_distance = distance_eq(i, int(red(pixels[loc])), int(green(pixels[loc])), int(blue(pixels[loc])));
        if (calculated_distance < ref_min_value){
           min_index = i;
           ref_min_value = calculated_distance;
        }
      }
      // print out each position
      println("closest to this combo " + min_index);
      println("(" + x_pos + "," + y_pos + ") r " + red(pixels[loc])+ " g " + green(pixels[loc]) + " b " + blue(pixels[loc]));
      output.println("(" + x_pos + "," + y_pos + ") r " + red(pixels[loc])+ " g " + green(pixels[loc]) + " b " + blue(pixels[loc]));
      min_index = 0;
      ref_min_value = 450;  
    }
  }
  
  updatePixels();
  
  println("bitwise op " + (4 & 3));
  println("dist " + distance_eq(4, 0, 40, 200));
  
  output.flush();  // write remaining data to file
  output.close();  // finish creating file
  exit();  // close the program
  
}

int distance_eq (int ref_combo, int r_px, int g_px, int b_px ){
  int ref_red = 0, 
      ref_green = 0,
      ref_blue = 0;
  
  // bitwise logic to assign ref_combo numbers
  if ((ref_combo & 1) > 0){
     ref_red = 255;
  }
  if ((ref_combo & 2) > 0){
    ref_green = 255;
  }
  if ((ref_combo & 4) > 0){
    ref_blue = 255; 
  }
  
  // calculate respective distances
  int red_difference = ref_red - r_px;
  int green_difference = ref_green - g_px;
  int blue_difference = ref_blue - b_px;
 
  // return distance formula calculation -- closer to 0 is better
  return int(sqrt(pow(red_difference,2) + pow(green_difference,2) + pow(blue_difference,2)));
}
