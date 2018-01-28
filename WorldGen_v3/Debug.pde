float maxHeight;
float minHeight;
float maxTemp;
float minTemp;
float maxHum;
float minHum;

void debugReset(){
 maxHeight = 0.5;
 minHeight = 0.5;
 maxTemp = 0.5;
 minTemp = 0.5;
 maxHum = 0.5;
 minHum = 0.5;
}

void debugHeightRange(float z){
  if(z > maxHeight){
    maxHeight = z;
  }
  if(z < minHeight){
    minHeight = z;
  }
}

void debugTempRange(float z){
  if(z > maxTemp){
    maxTemp = z;
  }
  if(z < minTemp){
    minTemp = z;
  }
}

void debugHumRange(float z){
  if(z > maxHum){
    maxHum = z;
  }
  if(z < minHum){
    minHum = z;
  }
}