public float[][] mergeMaps(float[][] mergedMap1, float[][] mergedMap2, float lerpAmount) {
  int mapHeight = mergedMap1.length;
  int mapWidth = mergedMap1[0].length;
  float[][] mergedHeightMap = new float[mapHeight][mapWidth];
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      mergedHeightMap[h][w] = (mergedMap1[h][w] * lerpAmount + mergedMap1[h][w] * mergedMap2[h][w] * (1-lerpAmount)) / 2 ;
    }
  }
  return mergedHeightMap;
}

public float[][] mergeMaps(float[][] mergedMap1, int mergedMap1Strength, float[][] mergedMap2, int mergedMap2Strength, float[][] mergedMap3, int mergedMap3Strength) {
  int mapHeight = mergedMap1.length;
  int mapWidth = mergedMap1[0].length;

  int totalStrength = mergedMap1Strength + mergedMap2Strength + mergedMap3Strength;
  float[][] mergedHeightMap = new float[mapHeight][mapWidth];
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      mergedHeightMap[h][w] = (mergedMap1[h][w] * mergedMap1Strength + mergedMap2[h][w] * mergedMap2Strength + mergedMap3[h][w] * mergedMap3Strength) / totalStrength;
    }
  }
  return mergedHeightMap;
}
