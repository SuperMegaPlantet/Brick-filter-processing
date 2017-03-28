import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;
boolean grid = true; //grid on/off
PImage img;
float resize=0.25;//resize input image with scale, control resolution
int w,h;//input image width and height 
int scale=12;//set draw pixel size
int brick01=0;//brick grayscale: 255
int brick02=0;//brick grayscale: 175
int brick03=0;//brick grayscale: 125
int brick04=0;//brick grayscale: 75
int brick05=0;//brick grayscale: 25
//grayscale RGB weight
float redWeight=0.222;
float greenWeight=0.707;
float blueWeight=0.071;

void setup(){
  img=loadImage("QR_.jpg") ;//pic.png
  //resize input image
  img.resize(int(img.width*resize),int(img.height*resize));
  //draw window adjust
  w=img.width*scale;//draw pixel maximal width =9
  h=img.height*scale;//draw pixel maimal height =9
  size(w, h); //size should be multiple of img width and height
  smooth();
  println("size:"+img.width+" x "+img.height);//print number of bricks
  brickNum();
}


void draw(){
 if (savePDF) beginRecord(PDF, timestamp()+".pdf");
 background(255);
 

 
 for (int gridX = 0; gridX < img.width; gridX++) {
    for (int gridY = 0; gridY < img.height; gridY++) {
      // grid position + tile size
      float tileWidth = width / (float)img.width;//tile size
      float tileHeight = height / (float)img.height;
      float posX = tileWidth*gridX;//grid position
      float posY = tileHeight*gridY;

      // get current color
      color c = img.pixels[gridY*img.width+gridX];
      // greyscale conversion
      int greyscale =round(red(c)*redWeight+green(c)*greenWeight+blue(c)*blueWeight);//r-0.222,g-0.707,b-0.071
      
      //set brick color by thresholding
       int brickColor;
        if(greyscale>200){
         brickColor=255; 
        }else if(greyscale>150&&greyscale<=200){
          brickColor=255;
        }else if(greyscale>100&&greyscale<=150){
         brickColor= 120;
        }else if(greyscale>50&&greyscale<=100){
         brickColor=120; 
        }else{
         brickColor=120;
        }
        
        //draw square
        fill(brickColor);
        rect(posX,posY,scale-1,scale-1);
        //draw circle
        stroke(255);
        //fill(greyscale-50,greyscale * mouseXFactor-50,255* mouseYFactor-50);
        int fillColor=brickColor-50;
        if(fillColor<0){
         fillColor=0; 
        }
        fill(fillColor);
        ellipse(posX+int(scale/2),posY+int(scale/2),int(scale/2),int(scale/2));
      
      
    }
    
 
 }
 
 if (savePDF) {
    savePDF = false;
    endRecord();
  }
  
if(grid== true){
fill(0,153,204,40);
rect(0,0,scale*10,scale*10);
rect(scale*10*2,0,scale*10,scale*10);
rect(scale*10*4,0,scale*10,scale*10);
rect(scale*10*6,0,scale*10,scale*10);
rect(scale*10*8,0,scale*10,scale*10);
////////////////////////////////////////
rect(scale*10,scale*10,scale*10,scale*10);
rect(scale*10*3,scale*10,scale*10,scale*10);
rect(scale*10*5,scale*10,scale*10,scale*10);
rect(scale*10*7,scale*10,scale*10,scale*10);
/////////////////////////////////////////
rect(0,scale*10*2,scale*10,scale*10);
rect(scale*10*2,scale*10*2,scale*10,scale*10);
rect(scale*10*4,scale*10*2,scale*10,scale*10);
rect(scale*10*6,scale*10*2,scale*10,scale*10);
rect(scale*10*8,scale*10*2,scale*10,scale*10);
//////////////////////////////////////////////
rect(scale*10,scale*10*3,scale*10,scale*10);
rect(scale*10*3,scale*10*3,scale*10,scale*10);
rect(scale*10*5,scale*10*3,scale*10,scale*10);
rect(scale*10*7,scale*10*3,scale*10,scale*10);
/////////////////////////////////////////////////
rect(0,scale*10*4,scale*10,scale*10);
rect(scale*10*2,scale*10*4,scale*10,scale*10);
rect(scale*10*4,scale*10*4,scale*10,scale*10);
rect(scale*10*6,scale*10*4,scale*10,scale*10);
rect(scale*10*8,scale*10*4,scale*10,scale*10);
//////////////////////////////////////////////////
rect(scale*10,scale*10*5,scale*10,scale*10);
rect(scale*10*3,scale*10*5,scale*10,scale*10);
rect(scale*10*5,scale*10*5,scale*10,scale*10);
rect(scale*10*7,scale*10*5,scale*10,scale*10);
/////////////////////////////////////////////////
rect(0,scale*10*6,scale*10,scale*10);
rect(scale*10*2,scale*10*6,scale*10,scale*10);
rect(scale*10*4,scale*10*6,scale*10,scale*10);
rect(scale*10*6,scale*10*6,scale*10,scale*10);
rect(scale*10*8,scale*10*6,scale*10,scale*10);
///////////////////////////////////////////////////
rect(scale*10,scale*10*7,scale*10,scale*10);
rect(scale*10*3,scale*10*7,scale*10,scale*10);
rect(scale*10*5,scale*10*7,scale*10,scale*10);
rect(scale*10*7,scale*10*7,scale*10,scale*10);
////////////////////////////////////////////////
rect(0,scale*10*8,scale*10,scale*10);
rect(scale*10*2,scale*10*8,scale*10,scale*10);
rect(scale*10*4,scale*10*8,scale*10,scale*10);
rect(scale*10*6,scale*10*8,scale*10,scale*10);
rect(scale*10*8,scale*10*8,scale*10,scale*10);
}

}

void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

//calculate 5 color bricks number
void brickNum(){
   for (int gridX = 0; gridX < img.width; gridX++) {
    for (int gridY = 0; gridY < img.height; gridY++) {
       // get current color
       color c = img.pixels[gridY*img.width+gridX];
       // greyscale conversion
       int greyscale =round(red(c)*redWeight+green(c)*greenWeight+blue(c)*blueWeight);
       if(greyscale>200){
         brick01+=1; 
        }else if(greyscale>150&&greyscale<=200){
          brick02+=1;
        }else if(greyscale>100&&greyscale<=150){
         brick03+=1;
        }else if(greyscale>50&&greyscale<=100){
         brick04+=1; 
        }else{
         brick05+=1;
        }
  }
}
println("brick01#:"+brick01);
println("brick02#:"+brick02);
println("brick03#:"+brick03);
println("brick04#:"+brick04);
println("brick05#:"+brick05);
}
