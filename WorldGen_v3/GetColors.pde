color baseHeight = color(105, 130, 80);
color topHeight = color(55, 58, 58);
color baseTemp = color(151, 237, 252);
color topTemp = color(255, 161, 0);
color baseHum = color(151, 237, 252);
color topHum = color(0, 60, 242);

color seaC = color(85, 155, 168);
color textC = color(0);

color getColorHeight(float z){
  if (greyScale){
    return color(map(z,0,1,0,255));
  }
  else{
    return lerpColor(baseHeight, topHeight, z);
  }
}

color getColorTemp(float z){
  if (greyScale){
    return color(map(z,0,1,0,255));
  }
  else{
    return lerpColor(baseTemp, topTemp, z);
  }
}

color getColorHum(float z){
  if (greyScale){
    return color(map(z,0,1,0,255));
  }
  else{
    return lerpColor(baseHum, topHum, z);
  }
}

color getColorBiome(float t, float h){
  if(h < 0){h = 0;};
  if(h > 1){h = 1;};
  if(t < 0){t = 0;};
  if(t > 1){t = 1;};
  int hum = (int)map(h, 0, 1, 0, 50);
  int tem = (int)map(t, 0, 1, 0, 50);
  return biomes.get(tem, hum);
}

color getColorBiomeShader(float t, float h){
  if(h < 0){h = 0;};
  if(h > 1){h = 1;};
  if(t < 0){t = 0;};
  if(t > 1){t = 1;};
  int hum = (int)map(h, 0, 1, 0, 50);
  int tem = (int)map(t, 0, 1, 0, 50);
  return biomesShader.get(tem, hum);
}