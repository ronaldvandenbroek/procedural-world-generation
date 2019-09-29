import controlP5.*;

ControlP5 cp5;
float[][] terrainMap;
int mapWidth, mapHeight;

//Default starting values
int seed = 1;
float intensity = 3;//'Best' between 5 and 30 
float falloff = 3.5;//'Best' between 0 and 5
int octaves = 7;
int power = 30;

public void setup() {
  //Setup window and map
  size(1024, 1024);
  terrainMap = new float[height][width];
  mapWidth = width;
  mapHeight = height;

  //Configure GUI
  cp5 = new ControlP5(this);
  cp5.addSlider("intensity").setPosition(0, 00).setRange(1, 30);
  cp5.addSlider("power").setPosition(0, 10).setRange(0, 50);
  cp5.addSlider("falloff").setPosition(0, 20).setRange(0, 10);
  cp5.addSlider("octaves").setPosition(0, 30).setRange(1, 15);
  
  //Generate default map
  generateHeightMap();
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
  float[][] terrainMapLarge = generateRidgeHeightMap(mapWidth, mapHeight, seed, octaves, falloff, intensity, power);
  //float[][] terrainMapMedium = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 7, 3.5f, 3, 30);
  //float[][] terrainMapSmall = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 11, 4, 8, 20);
  //terrainMap = mergeHeightMaps(terrainMapLarge, terrainMapMedium, 0.7f);
  //terrainMap = mergeHeightMaps(terrainMapLarge, terrainMapSmall, 0.6f);
  terrainMap = normaliseMinAndMaxHeight(terrainMapLarge);
  drawTerrainMap();
}
