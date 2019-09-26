void loadImages(){
    biomeIcons[0] = loadImage("Icons\\Grass.png");
    biomeIcons[1] = loadImage("Icons\\Dune.png");
    biomeIcons[2] = loadImage("Icons\\Savanna_Tree.png");
    biomeIcons[3] = loadImage("Icons\\Temperate_Tree.png");
    biomeIcons[4] = loadImage("Icons\\Boreal_Tree.png");
    biomeIcons[5] = loadImage("Icons\\Jungle_Tree.png");
    biomeIcons[6] = loadImage("Icons\\Mediteranian_Tree.png");
    biomeIcons[7] = loadImage("Icons\\Cactus.png");
    
    biomeBlends[0] = createBaseTileFloor(loadImage("Blend\\Water.png"));
    biomeBlends[1] = createBaseTileFloor(loadImage("Blend\\Gravel.png"));
    biomeBlends[2] = createBaseTileFloor(loadImage("Blend\\Savanna.png"));
    biomeBlends[3] = createBaseTileFloor(loadImage("Blend\\TempJungle.png"));
    biomeBlends[4] = createBaseTileFloor(loadImage("Blend\\Jungle.png"));
    biomeBlends[5] = createBaseTileFloor(loadImage("Blend\\Dryland.png"));
    biomeBlends[6] = createBaseTileFloor(loadImage("Blend\\Grass.png"));
    biomeBlends[7] = createBaseTileFloor(loadImage("Blend\\Bush.png"));
    biomeBlends[8] = createBaseTileFloor(loadImage("Blend\\TempForest.png"));
    biomeBlends[9] = createBaseTileFloor(loadImage("Blend\\BorealForest.png"));
    biomeBlends[10] = createBaseTileFloor(loadImage("Blend\\WetBorealForest.png"));
    biomeBlends[11] = createBaseTileFloor(loadImage("Blend\\Tundra.png"));
    
    //biomes = loadImage("Color\\BiomesV2.bmp");
    biomes = loadImage("Color\\BiomesV3.bmp");
    biomesShader = loadImage("Color\\BiomesMapShade.bmp");
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
