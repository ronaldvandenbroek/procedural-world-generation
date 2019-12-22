color seaColor = color(85, 155, 168);

color getGreyScale(float i) {
  return color(i);
}

color getColorBiome(float t, float h) {
  float hum = map(h, 0, 255, 0, 50);
  float tem = map(t, 0, 255, 0, 50);
  return biomes.get(int(tem), int(hum));
}
