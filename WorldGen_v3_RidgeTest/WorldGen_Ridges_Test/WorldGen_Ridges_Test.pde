float[][] terrainMap; 
int power = 30;
int intensity = 2;//2
int octaves = 7;//3
float falloff = 3.5f;//5

Slider slider;
float CSize = 20f; 

public void setup() {
  size(1024, 1024);
  terrainMap = new float[height][width];
  slider = new Slider("Intensity", CSize, 1, 10, 10, 50, 150, 20, HORIZONTAL);
}

public void draw() {
  draw_terrainMap();
  slider.display();
}

public void keyPressed() {
  noiseSeed( (long)random(0, 10000));
  switch (key) {
  case '1': //Renew
    terrainMap = generateRidgeHeightMap(width, height, octaves, falloff, intensity, power);
    break;
  }
  switch (key) {
  case '2': //Renew
    gen_smooth_perlin();
    break;
  }
}

void mouseDragged(){
  slider.mouseDragged();
  CSize = slider.val;
  println("valor: " + CSize);
}

void mouseReleased(){
  slider.mouseReleased();
  CSize = slider.val;
  println("valor: " + CSize);
}
