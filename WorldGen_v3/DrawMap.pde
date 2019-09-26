void drawMap() {
  println("Drawing biomes");
  loadPixels();
  if (displayType == 1) { //Height map
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {

        //Heightmap v2 built for exporting
        pixels[h * width + w] = getColorHeight(terrainMap[h][w][0] - 0.21);

        //Heightmap v1 not useful for exporting (Colors sealevel)
        //if (terrainMap[h][w][0] > (cutoff / 100.0f)){
        //  pixels[h * 1000 + w] = getColorHeight(terrainMap[h][w][0]);
        //}
        //else{
        //  pixels[h * 1000 + w] = seaC;
        //}
      }
    }
  } else if (displayType == 2) {//Temp map
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        pixels[h * width + w] = getColorTemp(terrainMap[h][w][1]);
      }
    }
  } else if (displayType == 3) {//Hum map
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        pixels[h * width + w] = getColorHum(terrainMap[h][w][2]);
      }
    }
  } else if (displayType == 4) {//Biome map
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        if (terrainMap[h][w][0] == cutoff / 100.0f) {
          pixels[h * width + w] = seaC;
        } else {
          pixels[h * width + w] = getColorBiome(terrainMap[h][w][1], terrainMap[h][w][2]);
        }
      }
    }
  } else if (displayType == 5) {//Pressure map
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        pixels[h * width + w] = getColorTemp(terrainMap[h][w][3]);
      }
    }
  } else if (displayType == 6) {//Hum map
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        pixels[h * width + w] = getColorHum(terrainMap[h][w][5]);
      }
    }
  } else if (displayType == 7) {//Hum map
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        pixels[h * width + w] = getColorHum(terrainMap[h][w][6]);
      }
    }
  } else if (displayType == 8) {//Hum map
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        pixels[h * width + w] = getColorHum(terrainMap[h][w][7]);
      }
    }
  } else if (displayType == 9) {//Icon test
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        if (terrainMap[h][w][0] == cutoff / 100.0f) {
          pixels[h * width + w] = seaC;
        } else {
          pixels[h * width + w] = getColorBiomeShader(terrainMap[h][w][1], terrainMap[h][w][2]);
        }
      }
    }
  }



  //Mountainside test
  if (displayType == 4 || displayType == 0) {
    for (int h = 5; h < height - 5; h++) {
      for (int w = 5; w < width - 5; w++) {
        if (abs(terrainMap[h][w][0] - terrainMap[h+4][w][0]) > 0.08 || 
          abs(terrainMap[h][w][0] - terrainMap[h-4][w][0]) > 0.08 || 
          abs(terrainMap[h][w][0] - terrainMap[h][w+4][0]) > 0.08 || 
          abs(terrainMap[h][w][0] - terrainMap[h][w-4][0]) > 0.08) {
          pixels[h * width + w] = getMountainBiome();
        }
      }
    }
  }
  updatePixels();

  //After generation if heightmap save to file
  if (displayType == 1) {
    save(saveLocation + seed + "heightmap.bmp");
  } else if (displayType == 0) {
    save(saveLocation + seed + "texturemap.bmp");
  }
}
