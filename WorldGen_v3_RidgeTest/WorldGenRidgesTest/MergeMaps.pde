public float[][] mergeMaps(float[][] mergedMap1, float[][] mergedMap2, float lerpAmount) {
  int mapHeight = mergedMap1.length;
  int mapWidth = mergedMap1[0].length;
  float[][] mergedHeightMap = new float[mapHeight][mapWidth];
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      //ridgeHeightMap[h][w] = lerp(heightMap1[h][w], heightMap2[h][w], lerpAmount);
      mergedHeightMap[h][w] = (mergedMap1[h][w] * lerpAmount + mergedMap1[h][w] * mergedMap2[h][w] * (1-lerpAmount)) / 2 ;
    }
  }
  return mergedHeightMap;
}
