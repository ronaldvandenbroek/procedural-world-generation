float[][] terrainMap;

public void setup() {
  size(1024, 1024);
  terrainMap = new float[height][width];
  generateHeightMap();
}

public void draw() {
  //
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
  float[][] terrainMapLarge = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 7, 3.5f, 2, 30);
  //float[][] terrainMapMedium = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 7, 3.5f, 3, 30);
  float[][] terrainMapSmall = generateRidgeHeightMap(1024, 1024, (long)random(0, 10000), 11, 4, 8, 20);
  //terrainMap = mergeHeightMaps(terrainMapLarge, terrainMapMedium, 0.7f);
  terrainMap = mergeHeightMaps(terrainMapLarge, terrainMapSmall, 0.7f);
  terrainMap = normaliseMinAndMaxHeight(terrainMapLarge);
  draw_terrainMap();
}
