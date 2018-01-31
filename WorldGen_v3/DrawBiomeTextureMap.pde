void drawBiomeTextureMap(){
       background(255);
       println("Loading Sea");
      image(prep_biome_texture(biomeBlends[0], true, "00000000"),0,0);//Sea
      println("Loading Desert");
      image(prep_biome_texture(biomeBlends[1], false, "FFFFEA8E"),0,0);//Desert
      println("Loading Savanna");
      image(prep_biome_texture(biomeBlends[2], false, "FFBDB25F"),0,0);//Savanna
      println("Loading TempRainForest");
      image(prep_biome_texture(biomeBlends[3], false, "FF5BA008"),0,0);//TempRainForest
      println("Loading RainForest");
      image(prep_biome_texture(biomeBlends[4], false, "FF056621"),0,0);//RainForest
      println("Loading Dryland");
      image(prep_biome_texture(biomeBlends[5], false, "FFC4D888"),0,0);//Dryland/ColdDesert
      println("Loading Grassland");
      image(prep_biome_texture(biomeBlends[6], false, "FF8DB360"),0,0);//Grassland
      println("Loading TempForest");
      image(prep_biome_texture(biomeBlends[7], false, "FF537B09"),0,0);//TempForest
      println("Loading WetTempForest");
      image(prep_biome_texture(biomeBlends[8], false, "FF687942"),0,0);//WetTempForest
      println("Loading BorealForest");
      image(prep_biome_texture(biomeBlends[9], false, "FF47875A"),0,0);//BorealForest
      println("Loading WetBorealForest");
      image(prep_biome_texture(biomeBlends[10], false, "FF69A055"),0,0);//WetBorealForest
      println("Loading Wasteland");
      image(prep_biome_texture(biomeBlends[1], false, "FFA0A0A0"),0,0);//Wasteland
      println("Loading Artic");
      image(prep_biome_texture(biomeBlends[0], false, "FFFFFFFF"),0,0);//Artic
      println("Loading Tundra");
      image(prep_biome_texture(biomeBlends[11], false, "FFDDFFF7"),0,0);//Tundra
      println("Loading Done");
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
              biomeTexture.pixels[h * 1000 + w] = color(seaC); 
            }
            else if(terrainMap[h][w][0] > cutoff / 100.0f && pHex.equals(hex)){
              //println("Match");
                biomeTexture.pixels[h * 1000 + w] = getColorBiome(terrainMap[h][w][1], terrainMap[h][w][2]); 
            }
            else{
              biomeTexture.pixels[h * 1000 + w] = color(0); 
            }
        }
      }
      biomeTexture.updatePixels();
      biomeTexture.blend(biomeBlend, 0, 0, 1000, 1000, 0, 0, 1000, 1000, DARKEST);
      
      //Change all non biome pixels to transparant (all pure black pixels)
      biomeTexture.loadPixels();
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          if(hex(biomeTexture.get(w, h)).equals("FF000000")){
            biomeTexture.pixels[h * 1000 + w] = color(0,0,0,0); 
          }
        }
      } 
    return biomeTexture;
}