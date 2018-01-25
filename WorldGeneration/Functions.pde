String getSettings() {
 String settings = "Settings: ";
 settings = settings + "| Wireframe: " + wireFrame;
 settings = settings + "| RenderMode: " + renderMode;
 settings = settings + "| Scale: " + scale;
 settings = settings + "| Intensity: " + intensity;
 settings = settings + "| Wlvl: " + waterlvl;
 settings = settings + "| Blvl: " + beachlvl;
 settings = settings + "| Plvl: " + plainlvl;
 settings = settings + "| Flvl: " + forestlvl;
 settings = settings + "| Mlvl: " + mountainlvl;
 settings = settings + "| Slvl: " + snowlvl;
 return settings;
}

void NewSeed() {
 seed = random(-1000, 1000);
}

int[] getColor(float terrainHeight) {
 int[] rgb = new int[3];
 if (terrainHeight < waterlvl) {
  rgb[0] = 30;
  rgb[1] = 144;
  rgb[2] = 255;
  return rgb;
 } else if (terrainHeight < beachlvl) {
  rgb[0] = 76;
  rgb[1] = 70;
  rgb[2] = 50;
  return rgb;
 } else if (terrainHeight < plainlvl) {
  rgb[0] = 0;
  rgb[1] = 204;
  rgb[2] = 0;
  return rgb;
 } else if (terrainHeight < forestlvl) {
  rgb[0] = 0;
  rgb[1] = 51;
  rgb[2] = 25;
  return rgb;
 } else if (terrainHeight < mountainlvl) {
  rgb[0] = 128;
  rgb[1] = 128;
  rgb[2] = 128;
  return rgb;
 } else if (terrainHeight < snowlvl) {
  rgb[0] = 255;
  rgb[1] = 255;
  rgb[2] = 255;
  return rgb;
 } else {
  return rgb;
 }
}