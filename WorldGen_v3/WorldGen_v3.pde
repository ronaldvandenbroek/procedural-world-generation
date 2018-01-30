float[][][] terrainMap; 
//y, x, type
//      0 = height
//      1 = temperature
//      2 = humidityFinal
//      3 = biome
//      4 = humidity/wind v2]
//      5 = humidityPass1
//      6 = humidityPass2
//      7 = humidityPass3

PFont font;
PFont fontSmall;
PImage biomes;
PImage biomesShader;
PImage[] biomeIcons = new PImage[8];
PImage[] biomeBlends = new PImage[8];
PImage blendBiomes;

//Default starting values
long seed = 4648;
int intensity = 3;
int octaves = 8;
int falloff = 7;
int intensityRidge = 3;
int octavesRidge = 3;
int falloffRidge = 7;
int cutoff = 21;
int windDir = 8;
int equatorOffset = 0;
int ridgeFactor = 28;

boolean edge = true;
boolean greyScale = false;
boolean debug = false;
boolean terrainCurving = true;
boolean rainSmoothing = false;
boolean runOnce = true;

int displayType = 1;
//1 = heightmap
//2 = tempmap
//3 = total humiditymap
//4 = biome
//5 = humidity/wind v2
//6 = primary humiditymap
//7 = secondary left humiditymap
//8 = secondary right humiditymap
//9 = icon

public void setup() {
  size(1000, 1000);
  font = createFont("Arial",18,true);
  fontSmall = createFont("Arial",12,true);
  loadImages();
  biomes.loadPixels();
  refresh();
    
}

public void draw() {
  if (runOnce && (displayType == 9 || displayType == 1)) {
    addIcons();
  }
  else if (displayType == 0){
    drawBiomeTextureMap();
  }
  runOnce = false;
}
 
public void keyPressed(){
  keyPressedHandling(key);
  refresh();
  runOnce = true;
}

void refresh(){
  generate();
  drawMap();
  information();
}

void mousePressed(){
  pixelInfo();
}

void mouseMoved(){
  pixelInfoLive();
}