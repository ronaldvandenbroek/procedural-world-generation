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
   println("Draw biome");
       for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
            int biome = int(terrainMap[h][w][3]);
            //println(biome);
            switch(biome){
               case 1: //Rainforest
                  pixels[h * 1000 + w] = color(6, 94, 0);
                  break;
               case 2: //Swamp
                  pixels[h * 1000 + w] = color(41, 89, 61);
                  break;
              case 3: //Artic
                  pixels[h * 1000 + w] = color(219, 240, 252);
                  break;
              case 4: //Savanna
                  pixels[h * 1000 + w] = color(218, 255, 86);
                  break;
              case 5: //Temperate forest
                  pixels[h * 1000 + w] = color(54, 165, 56);
                  break;
              case 6: //Tundra
                  pixels[h * 1000 + w] = color(239, 239, 239);
                  break;
              case 7: //Desert
                  pixels[h * 1000 + w] = color(239, 209, 86);
                  break;
              case 8: //Plains
                  pixels[h * 1000 + w] = color(126, 255, 71);
                  break;
              case 9: //Wasteland
                  pixels[h * 1000 + w] = color(99, 89, 79);
                  break;
             default:
                   pixels[h * 1000 + w] = seaC;
                   break;
            }
        }
      }
    }
    updatePixels();
}