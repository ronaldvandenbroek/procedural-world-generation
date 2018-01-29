float[][] terrainMap; 
int intensity = 3;
int octaves = 4;
int falloff = 3;

public void setup() {
    size(1000, 1000);
    terrainMap = new float[height][width];
    
}

public void draw() {
    //
}

public void keyPressed(){
  noiseSeed( (long)random(0, 10000));
      switch (key) {
        case '1': //Renew
        gen_ridges();
        break;  
      }
      switch (key) {
        case '2': //Renew
        gen_smooth_perlin();
        break;  
      }
}