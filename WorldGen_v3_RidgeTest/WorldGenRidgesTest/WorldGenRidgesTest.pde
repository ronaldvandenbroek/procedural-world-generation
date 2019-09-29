import controlP5.*;

ControlP5 cp5;
float[][] terrainMap;
int mapWidth, mapHeight;

int position;

//Default starting values
int seed = 1;
float intensity1 = 3;//'Best' between 5 and 30 
float falloff1 = 2;//'Best' between 0 and 5
int octaves1 = 3;
int power1 = 7;
float circularFalloff1 = 0.2f;
float blendPower12 = 0.4f;
float intensity2 = 3;//'Best' between 5 and 30 
float falloff2 = 3.5;//'Best' between 0 and 5
int octaves2 = 7;
int power2 = 30;
float circularFalloff2 = 0;

public void setup() {
  //Setup window and map
  size(1024, 1024);
  terrainMap = new float[height][width];
  mapWidth = width;
  mapHeight = height;

  //Configure GUI
  cp5 = new ControlP5(this);
  createGUISlider("intensity1", 1, 30);
  createGUISlider("power1", 0, 50);
  createGUISlider("falloff1", 0, 10);
  createGUISlider("octaves1", 1, 15);
  createGUISlider("circularFalloff1", 0, 1);
  createGUISlider("blendPower12", 0, 1);
  createGUISlider("intensity2", 1, 30);
  createGUISlider("power2", 0, 50);
  createGUISlider("falloff2", 0, 10);
  createGUISlider("octaves2", 1, 15);
  createGUISlider("circularFalloff2", 0, 1);
  
  //Generate default map
  generateHeightMap();
}

public void createGUISlider(String name, int min, int max){
  cp5.addSlider(name).setPosition(0, position).setRange(min, max);
  position += 10;
}


public void draw() {
}

public void keyPressed() {
  switch (key) {
  case '1': //Previous Seed
    if (seed <= 0) {
      seed = 0;
    } else {
      seed -= 1;
    }
    generateHeightMap();
    break;
  case '2': //Next Seed
    seed += 1;
    generateHeightMap();
    break;
  }
}

public void generateHeightMap() {
  float[][] terrainMap1 = generateRidgeHeightMap(mapWidth, mapHeight, seed, octaves1, falloff1, intensity1, power1, circularFalloff1);
  float[][] terrainMap2 = generateRidgeHeightMap(mapWidth, mapHeight, seed+100, octaves2, falloff2, intensity2, power2, circularFalloff2);
  //float[][] terrainMapMedium = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 7, 3.5f, 3, 30);
  //float[][] terrainMapSmall = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 11, 4, 8, 20);
  terrainMap = mergeHeightMaps(terrainMap1, terrainMap2, blendPower12);
  //terrainMap = mergeHeightMaps(terrainMapLarge, terrainMapSmall, 0.6f);
  terrainMap = normaliseMinAndMaxHeight(terrainMap);
  drawTerrainMap();
}
