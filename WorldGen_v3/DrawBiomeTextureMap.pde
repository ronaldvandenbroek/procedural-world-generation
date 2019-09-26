void drawBiomeTextureMap(){
          biomeMaps = new PImage[14];
          biomeMap = new PImage(width,height,ARGB);
          println("Loading Sea");
          biomeMaps[0] = prep_biome_texture(biomeBlends[0], true, "00000000");//Sea
          println("Loading Desert");
          biomeMaps[1] = prep_biome_texture(biomeBlends[1], false, "FFFFEA8E");//Desert
          println("Loading Savanna");
          biomeMaps[2] = prep_biome_texture(biomeBlends[2], false, "FFBDB25F");//Savanna
          println("Loading TempRainForest");
          biomeMaps[3] = prep_biome_texture(biomeBlends[3], false, "FF5BA008");//TempRainForest
          println("Loading RainForest");
          biomeMaps[4] = prep_biome_texture(biomeBlends[4], false, "FF056621");//RainForest
          println("Loading Dryland");
          biomeMaps[5] = prep_biome_texture(biomeBlends[5], false, "FFC4D888");//Dryland/ColdDesert
          println("Loading Grassland");
          biomeMaps[6] = prep_biome_texture(biomeBlends[6], false, "FF8DB360");//Grassland
          println("Loading TempForest");
          biomeMaps[7] = prep_biome_texture(biomeBlends[7], false, "FF537B09");//TempForest
          println("Loading WetTempForest");
          biomeMaps[8] = prep_biome_texture(biomeBlends[8], false, "FF687942");//WetTempForest
          println("Loading BorealForest");
          biomeMaps[9] = prep_biome_texture(biomeBlends[9], false, "FF47875A");//BorealForest
          println("Loading WetBorealForest");
          biomeMaps[10] = prep_biome_texture(biomeBlends[10], false, "FF69A055");//WetBorealForest
          println("Loading Wasteland");
          biomeMaps[11] = prep_biome_texture(biomeBlends[1], false, "FFA0A0A0");//Wasteland
          println("Loading Artic");
          biomeMaps[12] = prep_biome_texture(biomeBlends[0], false, "FFFFFFFF");//Artic
          println("Loading Tundra");
          biomeMaps[13] = prep_biome_texture(biomeBlends[11], false, "FFDDFFF7");//Tundra
          println("Loading Done");
          for(int i = 0; i < biomeMaps.length; i++){
             biomeMap.blend(biomeMaps[i], 0, 0, width, height, 0, 0, width, height, LIGHTEST);
          }
       }

PImage prep_biome_texture(PImage biomeBlend, boolean sea, String hex){
      //println(hex);
      PImage biomeTexture = new PImage(width,height,ARGB);
      biomeTexture.loadPixels();
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
            String pHex = hex(getColorBiome(terrainMap[h][w][1], terrainMap[h][w][2]));
            //println(pHex +" "+ hex);
            if(sea && terrainMap[h][w][0] == cutoff / 100.0f){
              biomeTexture.pixels[h * width + w] = color(seaC); 
            }
            else if(terrainMap[h][w][0] > cutoff / 100.0f   && pHex.equals(hex)){
              if(shaderHeight){
                //if(terrainMap[h][w][0] < 1.0f){
                  float tHeight = terrainMap[h][w][0];
                 if(tHeight > 0.99){
                   tHeight = 0.99;
                 }
                 color bcolor = lerpColor(getColorBiome(terrainMap[h][w][1], terrainMap[h][w][2]), color(0), tHeight * 0.8);
                 biomeTexture.pixels[h * width + w] = bcolor;
                //}
              }
              else{
                biomeTexture.pixels[h * width + w] = getColorBiome(terrainMap[h][w][1], terrainMap[h][w][2]); 
              }
              

              //if(terrainMap[h][w][0] > 40 / 100.0f){//Hills
              //  color bcolor = lerpColor(getColorBiome(terrainMap[h][w][1], terrainMap[h][w][2]), color(0), terrainMap[h][w][0]);
              //  biomeTexture.pixels[h * width + w] = bcolor;
              //}
              //else{//Normal
              //  biomeTexture.pixels[h * width + w] = getColorBiome(terrainMap[h][w][1], terrainMap[h][w][2]); 
              //}
            }
            else{
              biomeTexture.pixels[h * width + w] = color(0); 
            }
        }
      }
      biomeTexture.updatePixels();
      biomeTexture.blend(biomeBlend, 0, 0, width, height, 0, 0, width, height, DARKEST);
      
      //Change all non biome pixels to transparant (all pure black pixels)
      biomeTexture.loadPixels();
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          if(hex(biomeTexture.get(w, h)).equals("FF000000")){
            biomeTexture.pixels[h * width + w] = color(0,0,0,0); 
          }
        }
      } 
    return biomeTexture;
}
