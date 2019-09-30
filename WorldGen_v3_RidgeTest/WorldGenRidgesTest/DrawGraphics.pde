void drawMap(int value) {
  loadPixels();
  switch(value) {
  case 0:
    drawPixelMap(heightMap);
    break;
  case 1:
    drawPixelMap(temperatureMap);
    break;
  case 2:
    drawPixelMap(humidityMap);
    break;
  case 3:
    drawBiomeMap(heightMap, temperatureMap, humidityMap);
  }
  updatePixels();
}

void drawPixelMap(float[][] map) {
  for (int h = 0; h < height; h++) {
    for (int w = 0; w < width; w++) {
      pixels[h * width + w] = getGreyScale(map[h][w]);
    }
  }
}

void drawBiomeMap(float[][] heightMap, float[][] temperatureMap, float[][] humidityMap) {
  for (int h = 0; h < height; h++) {
    for (int w = 0; w < width; w++) {
      if (heightMap[h][w] <= seaLevel) {
        pixels[h * width + w] = seaColor;
      } else {
        pixels[h * width + w] = getColorBiome(temperatureMap[h][w], humidityMap[h][w]);
      }
    }
  }
}
