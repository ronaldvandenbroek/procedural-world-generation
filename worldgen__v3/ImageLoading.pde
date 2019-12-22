void loadImages() {
  String iconPath = "resources\\icons\\";
  biomeIcons[0] = loadImage(iconPath + "grass.png");
  biomeIcons[1] = loadImage(iconPath + "dune.png");
  biomeIcons[2] = loadImage(iconPath + "savanna_tree.png");
  biomeIcons[3] = loadImage(iconPath + "temperate_tree.png");
  biomeIcons[4] = loadImage(iconPath + "boreal_tree.png");
  biomeIcons[5] = loadImage(iconPath + "jungle_tree.png");
  biomeIcons[6] = loadImage(iconPath + "mediteranian_tree.png");
  biomeIcons[7] = loadImage(iconPath + "cactus.png");

  String blendPath = "resources\\blend\\";
  biomeBlends[0] = createBaseTileFloor(loadImage(blendPath + "water.png"));
  biomeBlends[1] = createBaseTileFloor(loadImage(blendPath + "gravel.png"));
  biomeBlends[2] = createBaseTileFloor(loadImage(blendPath + "savanna.png"));
  biomeBlends[3] = createBaseTileFloor(loadImage(blendPath + "temperate_jungle.png"));
  biomeBlends[4] = createBaseTileFloor(loadImage(blendPath + "jungle.png"));
  biomeBlends[5] = createBaseTileFloor(loadImage(blendPath + "dryland.png"));
  biomeBlends[6] = createBaseTileFloor(loadImage(blendPath + "grass.png"));
  biomeBlends[7] = createBaseTileFloor(loadImage(blendPath + "bush.png"));
  biomeBlends[8] = createBaseTileFloor(loadImage(blendPath + "temperate_forest.png"));
  biomeBlends[9] = createBaseTileFloor(loadImage(blendPath + "boreal_forest.png"));
  biomeBlends[10] = createBaseTileFloor(loadImage(blendPath + "wet_boreal_forest.png"));
  biomeBlends[11] = createBaseTileFloor(loadImage(blendPath + "tundra.png"));

  String colorPath = "resources\\color\\";
  //biomes = loadImage(colorPath + "biome_map_v2.bmp");
  biomes = loadImage(colorPath + "biome_map_v3.bmp");
  biomesShader = loadImage(colorPath + "biome_map_greyscale.bmp");
}

PImage createBaseTileFloor(PImage img) {
  PImage background = new PImage(height, width);
  float colsB = width/img.width;
  float rowsB = height/img.height;
  if ( width%img.width > 0) {
    colsB++;
  }
  if ( height%img.height > 0) {
    rowsB++;
  }
  for (int y=0; y<rowsB; y++) {
    for (int x=0; x<colsB; x++) {
      background.set(x*img.width, y*img.height, img);
    }
  }
  return background;
}
