void drawMap(int value) {
  switch(value) {
  case 0:
    drawPixelMap(heightMap);
    break;
  case 1:
    drawPixelMap(temperatureMap);
    break;
  }
}

void drawPixelMap(float[][] map) {
  loadPixels();
  for (int h = 0; h < height; h++) {
    for (int w = 0; w < width; w++) {
      pixels[h * width + w] = color(map[h][w]);
    }
  }
  updatePixels();
}
