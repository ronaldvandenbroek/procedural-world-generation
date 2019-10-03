void export() {
  println("Export Started");
  saveMap(0, "heightMap");
  saveMap(3, "biomeMap");
  println("Export Complete");
}

void saveMap(int value, String name) {
  PImage image = createImage(width, height, RGB);
  image = drawMap(value, image);
  image.save("Exports/" + seed + " " + name + ".bmp");
}
