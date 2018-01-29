float[][] terrainMap; 
int intensity = 3;
int octaves = 3;
int falloff = 7;

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
}