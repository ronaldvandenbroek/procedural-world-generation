void addIcons(){
  for (int h = 0; h < height; h += 40) {
            for (int w = 0; w < width; w += 40) {
                if (w < width && h < height) {
                    if (terrainMap[h][w][0] > (cutoff / 100.0f)) {
                        color biome = getColorBiome(terrainMap[h][w][1], terrainMap[h][w][2]);
                        String bHex = hex(biome);
                        if (bHex.equals("FF8DB360")) { //Grassland
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[0], w + rw, h + rh);
                            }
                        } else if (bHex.equals("FFBDB25F")) { //Savanna
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[2], w + rw, h + rh);
                            }
                        } else if (bHex.equals("FF537B09")) { //Temperate forest
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[3], w + rw, h + rh);
                            }
                        } else if (bHex.equals("FF47875A")) { //Boreal forest
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[4], w + rw, h + rh);
                            }
                        } else if (bHex.equals("FFFFEA8E")) { //Hot desert
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[1], w + rw, h + rh);
                            }
                        } else if (bHex.equals("FFC4D888")) { //Colder desert
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[7], w + rw, h + rh);
                            }
                        } else if (bHex.equals("FF5BA008")) { //Mediteranian forest
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[6], w + rw, h + rh);
                            }
                        } else if (bHex.equals("FF5BA008")) { //Mediteranian forest
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[6], w + rw, h + rh);
                            }
                        } else if (bHex.equals("FF056621")) { //Mediteranian forest
                            int rh = (int) random(-20, 20);
                            int rw = (int) random(-20, 20);
                            if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1], terrainMap[h + rh][w + rw + 20][2])))) {
                                image(biomeIcons[5], w + rw, h + rh);
                            }
                        }
                    }
                }
            }
        }
}