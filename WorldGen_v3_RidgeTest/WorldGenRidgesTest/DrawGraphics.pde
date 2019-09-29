void drawHeightMap() {
  loadPixels();
  for (int h = 0; h < height; h++) {
    for (int w = 0; w < width; w++) {
      pixels[h * width + w] = color(heightMap[h][w]);
    }
  }
  updatePixels();
}
