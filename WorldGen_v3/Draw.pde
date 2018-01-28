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
              float fHum = terrainMap[h][w][2];
              float fTem = terrainMap[h][w][1];
              if(fHum < 0){fHum = 0;};
              if(fHum > 1){fHum = 1;};
              if(fTem < 0){fTem = 0;};
              if(fTem > 1){fTem = 1;};
              int hum = (int)map(fHum, 0, 1, 0, 50);
              int tem = (int)map(fTem, 0, 1, 0, 50);
              pixels[h * 1000 + w] = biomes.get(tem, hum);
          }

            }
        }
      }
    updatePixels();
}