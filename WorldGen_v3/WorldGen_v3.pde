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
PImage[] biomeBlends = new PImage[12];
PImage[] biomeMaps = new PImage[14];
PImage blendBiomes;
PImage biomeMap;

//Default starting values
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
String saveLocation = "C:/Users/ronald/Pictures/Terrain/Generated/";

//Settings
//For heightmap generation set greyscale to true and displaytype to 1
//boolean greyScale = false;
//boolean terrainCurving = true;
//int displayType = 0;
//long seed = 4648; //Default seed
//For demo set greyscale to false and displaytype to 0
boolean greyScale = true;
boolean terrainCurving = false;
int displayType = 1;
long seed = 2980; //VCC seed //3033 //1065

boolean edge = true;
boolean debug = false;
boolean rainSmoothing = false;
boolean runOnce = true;
boolean shaderHeight = true;

//0 = complete map
//1 = heightmap
//2 = tempmap
//3 = total humiditymap
//4 = biome
//5 = humidity/wind v2
//6 = primary humiditymap
//7 = secondary left humiditymap
//8 = secondary right humiditymap
//9 = icon

float xo;
float yo;
float zoom = 1;

public void setup() {
  size(1000, 1000);
  font = createFont("Arial",18,true);
  fontSmall = createFont("Arial",12,true);
  loadImages();
  biomes.loadPixels();
  refresh();
    
  xo = 0;
  yo = 0;
  noSmooth();
  //noStroke();
}

public void draw() {
  if (runOnce && displayType == 9) {
    addIcons();
  }
  else if (runOnce && displayType == 0){
    drawBiomeTextureMap();
  }
  runOnce = false;
  if(displayType == 0){
    translate(width/2, height/2);
    scale(zoom);
    background(255);
    image(biomeMap,xo -width/2 ,yo-height/2);
  }
}
 
public void keyPressed(){
  keyPressedHandling(key);
}

void refresh(){
  generate();
  drawMap();
  if(displayType != 0){
    information();
  }
}

void mousePressed(){
    if(displayType != 0){
        pixelInfo();
    }
}

void mouseMoved(){
  pixelInfoLive();
}

void mouseDragged(){
  xo = xo + ((mouseX - pmouseX) / zoom);
  yo = yo + ((mouseY - pmouseY)/ zoom);
}

void mouseWheel(MouseEvent event) {
  zoom -= event.getCount() / 2.00;
  if (zoom < 1.00){
    zoom = 1;
  }
}
