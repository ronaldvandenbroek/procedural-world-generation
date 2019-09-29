public float[][] generateRidgeHeightMap(int mapWidth, int mapHeight, long ridgeSeed, int ridgeOctaves, float ridgeFalloff, float ridgeIntensity, int ridgePower, float circularFalloff, boolean ridge) {
  noiseSeed(ridgeSeed);
  noiseDetail(ridgeOctaves, ridgeFalloff / 10.0f);
  float[][] ridgeHeightMap = new float[mapWidth][mapHeight];
  float yoff = 0;
  for (int h = 0; h < mapHeight; h++) {
    float xoff = 0;
    for (int w = 0; w < mapWidth; w++) {
      //Height Calculation
      float pHeight;
      if (ridge) {
        pHeight = getPerlinRidge(xoff, yoff);
      } else {
        pHeight = getPerlinNoise(xoff, yoff);
      }

      //Curve heightMap
      pHeight = pow(pHeight, ridgePower);

      //Heightmap falloff
      if (circularFalloff != 0) {
        pHeight -= circularFalloff(w, h, mapWidth, mapHeight, circularFalloff);
        if (pHeight <= 0) {
          pHeight = 0;
        }
      }

      //Set height
      ridgeHeightMap[h][w] = pHeight;
      xoff += (ridgeIntensity / 1000.0f);
    }
    yoff += (ridgeIntensity / 1000.0f);
  }
  return ridgeHeightMap;
}

public float getPerlinRidge(float x, float y) {
  return 1 - abs((noise(x, y) - 0.5) * -1);
}

public float getPerlinNoise(float x, float y) {
  return noise(x, y);
}

public float circularFalloff(int w, int h, int mapWidth, int mapHeight, float circularFalloff) {
  float circularFalloffStrength = 1/circularFalloff * 1000;
  int wCoord = w - (mapWidth / 2);
  int hCoord = h - (mapHeight / 2);
  return sqrt(sq(wCoord) + sq(hCoord)) / circularFalloffStrength;
}

public float[][] mergeHeightMaps(float[][] heightMap1, float[][] heightMap2, float lerpAmount) {
  int mapHeight = heightMap1.length;
  int mapWidth = heightMap1[0].length;
  float[][] ridgeHeightMap = new float[mapHeight][mapWidth];
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      //ridgeHeightMap[h][w] = lerp(heightMap1[h][w], heightMap2[h][w], lerpAmount);
      ridgeHeightMap[h][w] = (heightMap1[h][w] * lerpAmount + heightMap1[h][w] * heightMap2[h][w] * (1-lerpAmount)) / 2 ;
    }
  }
  return ridgeHeightMap;
}

public float[][] normaliseMinAndMaxHeight(float[][] heightMap) {
  int mapHeight = heightMap.length;
  int mapWidth = heightMap[0].length;

  float min = 1; // Highbound so min is always lower
  float max = 0; // Lowerbound so max is always heigher
  //Determine min and max value
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      if (heightMap[h][w] <= min) { 
        min = heightMap[h][w];
      }
      if (heightMap[h][w] >= max) { 
        max = heightMap[h][w];
      }
    }
  }
  println("MinMax1: " + min + " " + max);

  //Map terrain to 256 step heightmap
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      float result = map(heightMap[h][w], min, max, 0, 255);
      //println(heightMap[h][w] + " " + min + " " + max + " " + result);
      //println(result);
      heightMap[h][w] = result;
    }
  }

  float minNormal = 256.0f; // Highbound so min is always lower
  float maxNormal = -256.0f; // Lowerbound so max is always heigher
  //Determine min and max value
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      if (heightMap[h][w] <= minNormal) {
        minNormal = heightMap[h][w];
      }
      if (heightMap[h][w] >= maxNormal) {
        //println(heightMap[h][w]);
        maxNormal = heightMap[h][w];
      }
    }
  }
  println("MinMax2: " + int(minNormal) + " " + int(maxNormal));

  return heightMap;
}
