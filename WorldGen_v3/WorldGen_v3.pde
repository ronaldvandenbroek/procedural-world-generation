PFont font;
float[][] heightMap;
int intensity = 3;
long seed;
int octaves = 8;
int falloff = 7;
int cutoff = 41;
boolean edge = true;

public void setup() {
    size(1000, 1000);
    font = createFont("Arial",22,true);
    seed();
    generate();
    information();
}

public void draw() {
    //
}

public void keyPressed(){
      switch (key) {
        case 'q': //Renew
            seed();
            break;
      case 'a': //Renew
            edge = !edge;        
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
      generate();
      information();
}