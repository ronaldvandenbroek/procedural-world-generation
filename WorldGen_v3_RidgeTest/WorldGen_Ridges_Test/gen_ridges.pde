public float[][] generateRidgeHeightMap(int mapWidth, int mapHeight, int ridgeOctaves, float ridgeFalloff, float ridgeIntensity, int ridgePower) {
  noiseDetail(ridgeOctaves, ridgeFalloff / 10.0f);
  float[][] ridgeHeightMap = new float[mapWidth][mapHeight];
  float yoff = 0;
  for (int h = 0; h < mapHeight; h++) {
    float xoff = 0;
    for (int w = 0; w < mapWidth; w++) {
      //Heightcalculation
      float pHeight = getPerlinRidge(xoff, yoff);
      pHeight = pow(pHeight, ridgePower);
      //pheight -= circularFalloff(w, h);
      ridgeHeightMap[h][w] = pHeight;
      xoff += (ridgeIntensity / 1000.0f);
    }
    yoff += (ridgeIntensity / 1000.0f);
  }
  return ridgeHeightMap;
}

public float getPerlinRidge(float x, float y){
  return 1 - abs((noise(x, y) - 0.5) * -1);
}

public float circularFalloff(int w, int h) {
  int wCoord = w - (width / 2);
  int hCoord = h - (height / 2);
  return sqrt(sq(wCoord) + sq(hCoord)) / 1000;
}
