void keyPressedHandling(char pressedKey){
  switch (pressedKey) {
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
       case '0': 
            displayType = 0;
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
}