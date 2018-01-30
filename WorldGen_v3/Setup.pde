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
    biomeBlends[1] = createBaseTileFloor(loadImage("Blend\\Grass.png"));
    biomeBlends[2] = createBaseTileFloor(loadImage("Blend\\TempForest.png"));
    biomeBlends[3] = createBaseTileFloor(loadImage("Blend\\Savanna.png"));
    biomes = loadImage("Color\\BiomesV2.bmp");
    biomesShader = loadImage("Color\\BiomesMapShade.bmp");
}