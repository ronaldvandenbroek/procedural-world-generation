float maxHeight = 0.5;
float minHeight = 0.5;
float maxTemp = 0.5;
float minTemp = 0.5;


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