import controlP5.*;

ControlP5 cp5;

float[][] terrainMap;
float intensity = 3;//'Best' between 5 and 30 
float falloff = 3.5;//'Best' between 0 and 5
int octaves = 7;
int power = 30;

public void setup() {
  size(1024, 1024);
  terrainMap = new float[height][width];

  //Configure GUI
  cp5 = new ControlP5(this);
  cp5.addSlider("intensity").setPosition(0, 0).setRange(1, 30);
  cp5.addSlider("power").setPosition(0, 10).setRange(0, 50);
  cp5.addSlider("falloff").setPosition(0, 20).setRange(0, 10);
  cp5.addSlider("octaves").setPosition(0, 30).setRange(1, 15);
}

public void draw() {
}

public void keyPressed() {
  switch (key) {
  case '1': //New
    generateHeightMap();
    break;
  }
}

public void generateHeightMap() {
  noiseSeed( (long)random(0, 10000));
  //terrainMap = generateRidgeHeightMap(width, height, octaves, falloff, intensity, power);
  float[][] terrainMapLarge = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), octaves, falloff, intensity, power);
  //float[][] terrainMapMedium = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 7, 3.5f, 3, 30);
  //float[][] terrainMapSmall = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 11, 4, 8, 20);
  //terrainMap = mergeHeightMaps(terrainMapLarge, terrainMapMedium, 0.7f);
  //terrainMap = mergeHeightMaps(terrainMapLarge, terrainMapSmall, 0.6f);
  terrainMap = normaliseMinAndMaxHeight(terrainMapLarge);
  draw_terrainMap();
}
