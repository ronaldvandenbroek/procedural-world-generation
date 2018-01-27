float[][][] terrainMap; 
//y, x, type
//      0 = height
//      1 = temperature
//      2 = humidity

PFont font;

//Default starting values
long seed = 9514;
int intensity = 3;
int octaves = 8;
int falloff = 7;
int cutoff = 41;

boolean edge = true;
boolean greyScale = false;
boolean debug = false;

int displayType = 1;
//1 = heightmap
//2 = tempmap

public void setup() {
    size(1000, 1000);
    font = createFont("Arial",22,true);
    //seed(); //Not needed if there is a default seed
    refresh();
}

public void draw() {
    //
}

public void keyPressed(){
      switch (key) {
        case '1': //Renew
            displayType = 1;
            break;
        case '2': //Renew
            displayType = 2;
            break;
        case 'q': //Renew
            seed();
            break;
      case 'a': //Renew
            edge = !edge;        
            break; 
       case 'x': //Renew
            debug = !debug;        
            break;        
      case 'z': //Renew
            greyScale = !greyScale;        
            break;
       case 'w': //Renew
            intensity = add(intensity, 1);
            break;
       case 's': //Renew
            intensity = remove(intensity, 1, 1);        
            break;
      case 'e': //Renew
            octaves = add(octaves, 1);
            break;
       case 'd': //Renew
            octaves = remove(octaves, 1, 1);           
            break;
      case 'r': //Renew
            falloff = add(falloff, 1);
            break;
      case 'f': //Renew
            falloff = remove(falloff, 1, 1);        
            break;    
      case 't': //Renew
            cutoff = add(cutoff, 1);
            break;
      case 'g': //Renew
            cutoff = remove(cutoff, 1, 1);        
            break;            
      }
      refresh();
}

void refresh(){
      generate();
      drawMap();
      information();
}