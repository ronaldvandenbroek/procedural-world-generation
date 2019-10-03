public void generateHumidityMap() {
  float[][] humidityMap1 = generateHumidityMapLayer(heightMap, temperatureMap, rainDirection1, seaLevel);
  float[][] humidityMap2 = generateHumidityMapLayer(heightMap, temperatureMap, rainDirection2, seaLevel);
  float[][] humidityMap3 = generateHumidityMapLayer(heightMap, temperatureMap, rainDirection3, seaLevel);

  humidityMap = mergeMaps(humidityMap1, rainDirection1Strength, humidityMap2, rainDirection2Strength, humidityMap3, rainDirection3Strength);
  humidityMap = normaliseMaps(humidityMap);
}

public float[][] generateHumidityMapLayer(float[][] heightMap, float[][] temperatureMap, int direction, int seaLevel) {
  int mapHeight = heightMap.length;
  int mapWidth = heightMap[0].length;

  float[][] generatedHumidityMap = new float[mapWidth][mapHeight];

  //Set initial humidity
  for (int h = 0; h < mapHeight; h++) {
    generatedHumidityMap[h][0] = 1.00;
    generatedHumidityMap[h][mapWidth-1] = 1.00;
  }
  for (int w = 0; w < mapWidth; w++) {
    generatedHumidityMap[0][w] = 1.00;
    generatedHumidityMap[mapHeight-1][w] = 1.00;
  }

  int wDir = 0;
  int hDir = 0;
  int wCount = 1;
  int hCount = 1;
  int wStart = 0;
  int hStart = 0;

  switch(direction) {
  case 1:
    wDir = 1;
    break;
  case 2:
    wDir = 1;
    hDir = 1;
    break;
  case 3:
    hDir = 1;
    break;
  case 4:
    wDir = -1;
    hDir = 1;
    wStart = mapWidth-1;
    break;
  case 5:
    wDir = -1;
    wStart = mapWidth-1;
    break;
  case 6:
    wDir = -1;
    hDir = -1;
    wStart = mapWidth-1;
    hStart = mapHeight-1;
    break;
  case 7:
    hDir = -1;
    hStart = mapHeight-1;
    break;
  case 8:
    wDir = 1;
    hDir = -1;
    hStart = mapHeight-1;
    break;
  }

  if (hDir == -1) {
    hCount = -1;
  }
  if (wDir == -1) {
    wCount = -1;
  }

  //Move humidity from left to right
  for (int h = hStart; isAtEndHeight(h, hStart); h = h + hCount) {
    for (int w = wStart; isAtEndWidth(w, wStart); w = w + wCount) {
      if (heightMap[h][w] <= seaLevel) {//If is water and humidity isn't already max
        if (generatedHumidityMap[h][w] < (1.00f)) {
          generatedHumidityMap[h + hDir][w + wDir] = generatedHumidityMap[h][w] + (0.0005f); //Increase humidty in the tile to the right
        } else {
          generatedHumidityMap[h + hDir][w + wDir] = generatedHumidityMap[h][w]; //Set max humidty in the tile to the right
        }
      } else if (heightMap[h][w] >= seaLevel) {//If is land and humidity isn't already 0
        if (generatedHumidityMap[h][w] > 0.00f) {
          //Code for humidity decrease
          generatedHumidityMap[h + hDir][w + wDir] = generatedHumidityMap[h][w] - ((0.0025f * (heightMap[h][w] * 4 +  (1- temperatureMap[h][w]) * 1))); //Decrease humidty in the tile to the right
          //Base *   terrainheight       modif  invertet terrain temp    modif
        } else {
          generatedHumidityMap[h + hDir][w + wDir] = generatedHumidityMap[h][w]; //Set min humidty in the tile to the right
        }
      }
    }
  }
  return generatedHumidityMap;
}

boolean isAtEndHeight(int h, int hStart) {
  if (hStart == 0) {
    if (h < (height-1)) {
      return true;
    }
    return false;
  } else {
    if (h > 0) {
      return true;
    }
    return false;
  }
}

boolean isAtEndWidth(int w, int wStart) {
  if (wStart == 0) {
    if (w < (width-1)) {
      return true;
    }
    return false;
  } else {
    if (w > 0) {
      return true;
    }
    return false;
  }
}
