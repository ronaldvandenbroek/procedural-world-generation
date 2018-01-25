//Change-able settings
int scale = 5;
int w = 1000;
int h = 1000;
int renderMode = 1; // 1:2d, 2:3d
float intensity = 0.04;
boolean wireFrame = false;

//Unchangeable
int cols, rows;
float seed;
float[][] heightMap;

void setup(){
  size(1000, 1000, P3D);
  Generate();
  Draw();
}

void draw(){
  //
}

void keyPressed() {
  boolean regen = false;
  if (key == '1'){
     renderMode = 1;
  }
  else if (key == '2'){
     renderMode = 2;
  }
  else if (key == 'Q' || key == 'q'){
    regen = true;
  }
  else if (key == 'A' || key == 'a'){
    if (wireFrame){
      wireFrame = false;
    }
    else{
      wireFrame = true;
   }
  }
  else if (key == 'W' || key == 'w'){
    scale += 1;
    regen = true;
  }
    else if (key == 'S' || key == 's'){
    scale -= 1;
    if (scale < 1){scale = 1;}
    regen = true;
  } 
    else if (key == 'E' || key == 'e'){
    intensity += 0.002;
    regen = true;
  }
    else if (key == 'D' || key == 'd'){
    intensity -= 0.002;
    if (intensity < 0.002){intensity = 0.002;}
    regen = true;
  }

  if (regen){
     Generate();
  }
  Draw();
}