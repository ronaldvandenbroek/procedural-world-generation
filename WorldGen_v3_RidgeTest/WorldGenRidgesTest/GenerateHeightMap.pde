public void generateHeightMap() {
  float[][] heightMap1 = generateHeightMapLayer(mapWidth, mapHeight, seed, octaves1, falloff1, intensity1, power1, circularFalloff1, false);
  float[][] heightMap2 = generateHeightMapLayer(mapWidth, mapHeight, seed+100, octaves2, falloff2, intensity2, power2, circularFalloff2, true);
  heightMap = mergeMaps(heightMap1, heightMap2, blendPower12);
  heightMap = normaliseMaps(heightMap);
}

public float[][] generateHeightMapLayer(int mapWidth, int mapHeight, long mapSeed, int mapOctaves, float mapFalloff, float mapIntensity, int mapPower, float mapCircularFalloff, boolean ridge) {
  noiseSeed(mapSeed);
  noiseDetail(mapOctaves, mapFalloff / 10.0f);
  float[][] generatedHeightMap = new float[mapWidth][mapHeight];
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
      pHeight = pow(pHeight, mapPower);

      //Heightmap falloff
      if (mapCircularFalloff != 0) {
        pHeight -= circularFalloff(w, h, mapWidth, mapHeight, mapCircularFalloff);
        if (pHeight <= 0) {
          pHeight = 0;
        }
      }

      //Set height
      generatedHeightMap[h][w] = pHeight;
      xoff += (mapIntensity / 1000.0f);
    }
    yoff += (mapIntensity / 1000.0f);
  }
  return generatedHeightMap;
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
