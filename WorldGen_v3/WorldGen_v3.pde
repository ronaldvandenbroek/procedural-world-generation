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
boolean runOnce = false;

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
    biomeIcons[0] = loadImage("Icons\\Grass.png");
    biomeIcons[1] = loadImage("Icons\\Dune.png");
    biomeIcons[2] = loadImage("Icons\\Savanna_Tree.png");
    biomeIcons[3] = loadImage("Icons\\Temperate_Tree.png");
    biomeIcons[4] = loadImage("Icons\\Boreal_Tree.png");
    biomeIcons[5] = loadImage("Icons\\Jungle_Tree.png");
    biomeIcons[6] = loadImage("Icons\\Mediteranian_Tree.png");
    biomeIcons[7] = loadImage("Icons\\Cactus.png");
    biomes = loadImage("Color\\BiomesV2.bmp");
    biomesShader = loadImage("Color\\BiomesMapShade.bmp");
    biomes.loadPixels();
    //seed(); //Not needed if there is a default seed
    refresh();
    
}

public void draw() {
    //Grass
    if(runOnce && (displayType == 9 || displayType == 1)){
    for (int h = 0; h < height; h += 40) {
      for (int w = 0; w < width; w += 40) {
            if (w < width && h < height){
              if(terrainMap[h][w][0] > (cutoff / 100.0f)){
               color biome = getColorBiome(terrainMap[h][w][1],terrainMap[h][w][2]);
               String bHex = hex(biome);
               if (bHex.equals("FF8DB360")){//Grassland
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[0], w + rw, h + rh);
                   }
                }
                else if (bHex.equals("FFBDB25F")){//Savanna
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[2], w + rw, h + rh);
                   }
                }
                else if (bHex.equals("FF537B09")){//Temperate forest
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[3], w + rw, h + rh);
                   }
                }
               else if (bHex.equals("FF47875A")){//Boreal forest
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[4], w + rw, h + rh);
                   }
                }
              else if (bHex.equals("FFFFEA8E")){//Hot desert
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[1], w + rw, h + rh);
                   }
                }
               else if (bHex.equals("FFC4D888")){//Colder desert
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[7], w + rw, h + rh);
                   }
                }
                else if (bHex.equals("FF5BA008")){//Mediteranian forest
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[6], w + rw, h + rh);
                   }
                }
                else if (bHex.equals("FF5BA008")){//Mediteranian forest
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[6], w + rw, h + rh);
                   }
                }
                else if (bHex.equals("FF056621")){//Mediteranian forest
                   int rh = (int)random(-20, 20);
                   int rw = (int)random(-20, 20);
                   if (terrainMap[h + rh][w + rw + 20][0] > cutoff / 100.0f && bHex.equals(hex(getColorBiome(terrainMap[h + rh][w + rw + 20][1],terrainMap[h + rh][w + rw + 20][2])))){
                       image(biomeIcons[6], w + rw, h + rh);
                   }
                }
              }
            }
         }
    }
    runOnce = false;
    }
}

public void keyPressed(){
      switch (key) {
        case '1': 
            displayType = 1;
            break;
        case '2': 
            displayType = 2;
            break;
        case '3': 
            displayType = 3;
            break;
         case '4': 
            displayType = 4;
            break;  
        case '5': 
            displayType = 5;
            break;       
        case '6': 
            displayType = 6;
            break;  
       case '7': 
            displayType = 7;
            break;  
       case '8': 
            displayType = 8;
            break;
       case '9': 
            displayType = 9;
            break;     
        case 'q': 
            seed();
            break;
      case 'a': 
            edge = !edge;        
            break; 
       case 'x': 
            debug = !debug;        
            break;   
      case 'c': 
            terrainCurving = !terrainCurving;        
            break;        
      case 'z': 
            greyScale = !greyScale;        
            break;
     case 'v': 
            rainSmoothing = !rainSmoothing;        
            break;          
       case 'w': 
            intensity = add(intensity, 1);
            break;
       case 's': 
            intensity = remove(intensity, 1, 1);        
            break;
      case 'e': 
            octaves = add(octaves, 1);
            break;
       case 'd': 
            octaves = remove(octaves, 1, 1);           
            break;
      case 'r': 
            falloff = add(falloff, 1);
            break;
      case 'f': 
            falloff = remove(falloff, 1, 1);        
            break;    
      case 't': 
            cutoff = add(cutoff, 1);
            break;
      case 'g': 
            cutoff = remove(cutoff, 1, 1);        
            break;
      case 'y': 
            windDir = add(windDir, 1, 1, 8);      
            break;
     case 'h': 
            windDir = remove(windDir, 1, 1, 8);           
            break;     
      case 'u': 
            equatorOffset += 10;  
            break;
     case 'j': 
            equatorOffset -= 10;          
            break;     
     case 'i': 
            ridgeFactor += 1;  
            break;
     case 'k': 
            ridgeFactor -= 1;          
            break;            
      }
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