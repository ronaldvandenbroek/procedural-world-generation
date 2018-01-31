void drawMap(){
    println("Drawing biomes");
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
              pixels[h * 1000 + w] = getColorBiomeShader(terrainMap[h][w][1],terrainMap[h][w][2]);
          }
          }
        }
      }
   updatePixels();
}

PImage createBaseTileFloor(PImage img){
    PImage background = new PImage(height, width);
    float colsB = width/img.width;
    float rowsB = height/img.height;
    if( width%img.width > 0){colsB++;}
    if( height%img.height > 0){rowsB++;}
    for (int y=0; y<rowsB; y++){
      for (int x=0; x<colsB; x++){
        background.set(x*img.width,y*img.height, img);
      }
    }
    return background;
}