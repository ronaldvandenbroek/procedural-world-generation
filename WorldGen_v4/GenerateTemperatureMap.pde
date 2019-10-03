public void generateTemperatureMap() {
  temperatureMap = generateTemperatureMapLayer(heightMap, equatorOffset, temperatureFalloff, temperatureHeight);
  temperatureMap = normaliseMaps(temperatureMap);
}

public float[][] generateTemperatureMapLayer(float[][] heightMap, int mapEquatorOffset, float mapFalloffStrength, float mapHeightStrength) {
  int mapHeight = heightMap.length;
  int mapWidth = heightMap[0].length;

  float[][] generatedTemperatureMap = new float[mapWidth][mapHeight];
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      //generatedTemperatureMap[h][w] = lerp(horizontalFalloff(h, mapEquatorOffset, mapFalloffStrength), heightMap[h][w], mapHeightFalloffBlend);
      generatedTemperatureMap[h][w] = 1 - horizontalFalloff(h, mapEquatorOffset) * mapFalloffStrength - (heightMap[h][w] * mapHeightStrength);
    }
  }
  return generatedTemperatureMap;
}

public float horizontalFalloff(int h, int offset) {
  float hCoord = h - (height / 2) + offset;
  return abs(hCoord);
}
