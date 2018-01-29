void drawMap(){
    loadPixels();
    if (displayType == 1){ //Height map
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
            if (terrainMap[h][w][0] > (cutoff / 100.0f)){
              pixels[h * 1000 + w] = getColorHeight(terrainMap[h][w][0]);
            }
            else{
              pixels[h * 1000 + w] = seaC;
            }
        }
    }
    }
    else if (displayType == 2){//Temp map
       for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
              pixels[h * 1000 + w] = getColorTemp(terrainMap[h][w][1]);
        }
      }
    }
   else if (displayType == 3){//Hum map
       for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
              pixels[h * 1000 + w] = getColorHum(terrainMap[h][w][2]);
        }
      }
    }
   else if (displayType == 4){//Biome map
       for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          if(terrainMap[h][w][0] == cutoff / 100.0f){
            pixels[h * 1000 + w] = seaC;
          }
          else{
              pixels[h * 1000 + w] = getColorBiome(terrainMap[h][w][1],terrainMap[h][w][2]);
          }
          }
        }
      }
      else if (displayType == 5){//Pressure map
       for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
              pixels[h * 1000 + w] = getColorTemp(terrainMap[h][w][3]);
            }
        }
      }
         else if (displayType == 6){//Hum map
       for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
              pixels[h * 1000 + w] = getColorHum(terrainMap[h][w][5]);
        }
      }
    }
       else if (displayType == 7){//Hum map
       for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
              pixels[h * 1000 + w] = getColorHum(terrainMap[h][w][6]);
        }
      }
    }
       else if (displayType == 8){//Hum map
       for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
              pixels[h * 1000 + w] = getColorHum(terrainMap[h][w][7]);
        }
      }
    }
    else if (displayType == 9){//Icon test
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          if(terrainMap[h][w][0] == cutoff / 100.0f){
            pixels[h * 1000 + w] = seaC;
          }
          else{
              pixels[h * 1000 + w] = getColorBiome(terrainMap[h][w][1],terrainMap[h][w][2]);
          }
          }
        }
      }
    updatePixels();
    

}