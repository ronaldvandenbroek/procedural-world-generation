public float[][] normaliseMaps(float[][] normalisedMap) {
  int mapHeight = normalisedMap.length;
  int mapWidth = normalisedMap[0].length;

  float min = 1; // Highbound so min is always lower
  float max = 0; // Lowerbound so max is always heigher
  //Determine min and max value
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      if (normalisedMap[h][w] <= min) { 
        min = normalisedMap[h][w];
      }
      if (normalisedMap[h][w] >= max) { 
        max = normalisedMap[h][w];
      }
    }
  }
  println("MinMax1: " + min + " " + max);

  //Map terrain to 256 step heightmap
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      float result = map(normalisedMap[h][w], min, max, 0, 255);
      //println(heightMap[h][w] + " " + min + " " + max + " " + result);
      //println(result);
      normalisedMap[h][w] = result;
    }
  }

  float minNormal = 256.0f; // Highbound so min is always lower
  float maxNormal = -256.0f; // Lowerbound so max is always heigher
  //Determine min and max value
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      if (normalisedMap[h][w] <= minNormal) {
        minNormal = normalisedMap[h][w];
      }
      if (normalisedMap[h][w] >= maxNormal) {
        //println(heightMap[h][w]);
        maxNormal = normalisedMap[h][w];
      }
    }
  }
  println("MinMax2: " + int(minNormal) + " " + int(maxNormal));

  return normalisedMap;
}
