   public void generate(){

    terrainMap = new float[height][width][3];
    debugReset();
    
    calculateRidges();
    calculateHeightAndTemp();
    simulateRainHorizontally();
}

public void seed(){
   seed = (long)random(0, 10000);
}

public float circularFalloff(int w, int h){
    int wCoord = w - (width / 2);
    int hCoord = h - (height / 2);
    return sqrt(sq(wCoord) + sq(hCoord)) / 800.0;
}

public float diamondFalloff(int w, int h){
    int wCoord = w - (width / 2);
    int hCoord = h - (height / 2);
    return (abs(wCoord) + abs(hCoord)) / 1000.0;
}

public float horizontalFalloff(int h, int offset){
    int hCoord = h - (height / 2) + offset;
    return abs(hCoord) / 180.0;
}

public void calculateRidges() {
    noiseSeed(seed);
    noiseDetail(octavesRidge, falloffRidge / 10.0f);
     float yoff = 0;
    for (int h = 0; h < height; h++) {
        float xoff = 0;
        for (int w = 0; w < width; w++) {
            //Ridgescalculation
            
             float pheight = 1 - abs((noise(xoff, yoff) - 0.7) * -1);
             pheight -= circularFalloff(w, h);
             pheight = pow((pheight - 0.09), 5) + 0.2;
              terrainMap[h][w][0] = pheight;
            
            xoff += (intensityRidge / 1000.0f);
        }
        yoff += (intensityRidge / 1000.0f);
    }
}

public void calculateHeightAndTemp() {
      noiseSeed(seed);
    noiseDetail(octaves, falloff / 10.0f);
float yoff = 0;
    for (int h = 0; h < height; h++) {
        float xoff = 0;
        for (int w = 0; w < width; w++) {
            //Heightcalculation
           float pheight = noise(xoff, yoff);
           //pheight = pheight + (terrainMap[h][w][0] * (ridgeFactor/10.0));
           //pheight = lerp(pheight, terrainMap[h][w][0], ridgeFactor/10.0);
            if (edge){
              pheight -= circularFalloff(w, h);
            }
            if(terrainCurving){
              pheight = pow((pheight - 0.09), 5) + 0.2;
           } 
             pheight = lerp(pheight, terrainMap[h][w][0], ridgeFactor/10.0);
           
            if (pheight > (cutoff / 100.0f)){
              terrainMap[h][w][0] = pheight;
              terrainMap[h][w][1] = 1.1 - (lerp(horizontalFalloff(h, equatorOffset), pheight, 0.65)); //Hotter at the equator but gets colder the higher altitude you get
            }
            else{
              terrainMap[h][w][0] = cutoff / 100.0f;
              terrainMap[h][w][1] = 0.8 - (lerp(horizontalFalloff(h, equatorOffset), pheight, 0.7)); //Water temp (not important for calculations, just used for visual
            }
         
            
            //Debug logging
            debugHeightRange(terrainMap[h][w][0]);
            debugTempRange(terrainMap[h][w][1]);
            
            xoff += (intensity / 1000.0f);
        }
        yoff += (intensity / 1000.0f);
    }
}


public void simulateRainHorizontally(){
    //Set initial humidity
    for (int h = 0; h < (height); h++) {
         terrainMap[h][0][2] = 1.00;
         terrainMap[h][999][2] = 1.00;
    }
    for (int w = 0; w < (width); w++) {
            terrainMap[0][w][2] = 1.00;
            terrainMap[999][w][2] = 1.00;
    }
    
    int wDir = 0;
    int hDir = 0;
    int wCount = 1;
    int hCount = 1;
    int wStart = 0;
    int hStart = 0;
    switch(windDir){
        case 1:
          wDir = 1;
          break;
        case 2:
          wDir = 1;
          hDir = 1;
          break;
        case 3:
          hDir = 1;
          break;
        case 4:
          wDir = -1;
          hDir = 1;
          wStart = 999;
          break;
        case 5:
          wDir = -1;
          wStart = 999;
          break;
        case 6:
          wDir = -1;
          hDir = -1;
          wStart = 999;
          hStart = 999;
          break;
        case 7:
          hDir = -1;
          hStart = 999;
          break;
        case 8:
          wDir = 1;
          hDir = -1;
          hStart = 999;
          break;
    }
    
    if(hDir == -1){
      hCount = -1;
    }
    if(wDir == -1){
      wCount = -1;
    }
    
    //println("int h = " + hStart + "; h = h +" + hCount);
    //println("int w = " + wStart + "; w = w +" + wCount);
    //println("hDir = " + hDir + "; wDir = " + wDir);
    
    //Move humidity from left to right
    for (int h = hStart; isAtEndHeight(h, hStart); h = h + hCount) {
      //println("h = " + h);
        for (int w = wStart; isAtEndWidth(w, wStart); w = w + wCount) {
          //println("w = " + w);
            if(terrainMap[h][w][0] <= (cutoff / 100.0f)){//If is water and humidity isn't already max
                if(terrainMap[h][w][2] < 1.00f){
                  terrainMap[h + hDir][w + wDir][2] = terrainMap[h][w][2] + 0.001f; //Increase humidty in the tile to the right
                }
                else{
                  terrainMap[h + hDir][w + wDir][2] = terrainMap[h][w][2]; //Set max humidty in the tile to the right
                }
            }
            else if (terrainMap[h][w][0] >= (cutoff / 100.0f)){//If is land and humidity isn't already 0
                if(terrainMap[h][w][2] > 0.00f){
                  //Code for humidity decrease
                  terrainMap[h + hDir][w + wDir][2] = terrainMap[h][w][2] - (0.002f * (terrainMap[h][w][0] * 4 +  (1- terrainMap[h][w][1]) * 1)); //Decrease humidty in the tile to the right
                                                                  //Base *   terrainheight       modif  invertet terrain temp    modif
                }
                else{
                  //println(w);
                  terrainMap[h + hDir][w + wDir][2] = terrainMap[h][w][2]; //Set min humidty in the tile to the right
                }
            }
            debugHumRange(terrainMap[h][w][2]);
        }
    }
}

boolean isAtEndHeight(int h, int hStart){
  if(hStart == 0){
    if (h < (height-1)){
      return true;
    }
    return false;
  }
  else{
    if (h > 0){
      return true;
    }
    return false;
  }
}

boolean isAtEndWidth(int w, int wStart){
  if(wStart == 0){
    if (w < (width-1)){
      return true;
    }
    return false;
  }
  else{
    if (w > 0){
      return true;
    }
    return false;
  }
}