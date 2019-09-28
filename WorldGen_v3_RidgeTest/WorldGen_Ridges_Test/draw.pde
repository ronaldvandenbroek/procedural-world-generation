void draw_terrainMap() {
  loadPixels();
  for (int h = 0; h < height; h++) {
    for (int w = 0; w < width; w++) {
      pixels[h * width + w] = color(map(terrainMap[h][w], 0, 1, 0, 255));
    }
  }
  updatePixels();
}
