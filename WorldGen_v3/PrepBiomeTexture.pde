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