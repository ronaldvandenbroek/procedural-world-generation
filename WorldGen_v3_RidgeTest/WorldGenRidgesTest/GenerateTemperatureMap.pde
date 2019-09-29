public void generateTemperatureMap() {
  temperatureMap = generateTemperatureMapLayer(heightMap);
  temperatureMap = normaliseMaps(temperatureMap);
}

public float[][] generateTemperatureMapLayer(float[][] heightMap) {
  int mapHeight = heightMap.length;
  int mapWidth = heightMap[0].length;

  float[][] generatedTemperatureMap = new float[mapWidth][mapHeight];
  for (int h = 0; h < mapHeight; h++) {
    for (int w = 0; w < mapWidth; w++) {
      generatedTemperatureMap[h][w] = 1.1 - (lerp(horizontalFalloff(h, 0), heightMap[h][w] * 1.2, 0.65));
    }
  }
  return generatedTemperatureMap;
}

public float horizontalFalloff(int h, int offset) {
  int hCoord = h - (height / 2) + offset;
  return abs(hCoord) / 180.0;
}
