   public void generate(){

    terrainMap = new float[height][width][8];
    debugReset();
    
    println("Calculating Ridges");
    calculateRidges();
    println("Calculating Height and Temperature");
    calculateHeightAndTemp();
    println("Simulating Rain");
    simulateRain(windDir,  5);
    simulateRain(remove(windDir, 1, 1, 8), 6);
    simulateRain(add(windDir, 1, 1, 8), 7);
    println("Calculating Humidity");
    calculateHumidity();
}

public void seed(){
   seed = (long)random(0, 10000);
}

public float circularFalloff(int w, int h){
    int wCoord = w - (width / 2);
    int hCoord = h - (height / 2);
    return sqrt(sq(wCoord) + sq(hCoord)) / 500.0; //800
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
              pheight = lerp(pheight, terrainMap[h][w][0], ridgeFactor/10.0);
            }
           
            if (pheight > (cutoff / 100.0f)){
              terrainMap[h][w][0] = pheight;
              terrainMap[h][w][1] = 1.1 - (lerp(horizontalFalloff(h, equatorOffset), pheight * 1.2, 0.65)); //Hotter at the equator but gets colder the higher altitude you get
            }
            else{
              terrainMap[h][w][0] = cutoff / 100.0f;
              terrainMap[h][w][1] = 0.8 - (lerp(horizontalFalloff(h, equatorOffset), pheight * 1.2, 0.7)); //Water temp (not important for calculations, just used for visual
            }
         
            
            //Debug logging
            debugHeightRange(terrainMap[h][w][0]);
            debugTempRange(terrainMap[h][w][1]);
            
            xoff += (intensity / 1000.0f);
        }
        yoff += (intensity / 1000.0f);
    }
}


public void simulateRain(int dir, int pass){
    //Set initial humidity
    for (int h = 0; h < (height); h++) {
         terrainMap[h][0][5] = 1.00;
         terrainMap[h][999][5] = 1.00;
         terrainMap[h][0][6] = 1.00;
         terrainMap[h][999][6] = 1.00;
         terrainMap[h][0][7] = 1.00;
         terrainMap[h][999][7] = 1.00;
    }
    for (int w = 0; w < (width); w++) {
         terrainMap[0]  [w][5] = 1.00;
         terrainMap[999][w][5] = 1.00;
         terrainMap[0]  [w][6] = 1.00;
         terrainMap[999][w][6] = 1.00;
         terrainMap[0]  [w][7] = 1.00;
         terrainMap[999][w][7] = 1.00;
    }
    
    int wDir = 0;
    int hDir = 0;
    int wCount = 1;
    int hCount = 1;
    int wStart = 0;
    int hStart = 0;
    switch(dir){
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
   //println("dir = " + dir + "; hDir = " + hDir + "; wDir = " + wDir + "; cutoff = " + cutoff / 100.0f);
    
    //Move humidity from left to right
    for (int h = hStart; isAtEndHeight(h, hStart); h = h + hCount) {
      //println("h = " + h);
        for (int w = wStart; isAtEndWidth(w, wStart); w = w + wCount) {
          //println("w = " + w);
            if(terrainMap[h][w][0] <= (cutoff / 100.0f)){//If is water and humidity isn't already max
                if(terrainMap[h][w][pass] < (1.00f)){
                  terrainMap[h + hDir][w + wDir][pass] = terrainMap[h][w][pass] + (0.0005f); //Increase humidty in the tile to the right
                }
                else{
                  terrainMap[h + hDir][w + wDir][pass] = terrainMap[h][w][pass]; //Set max humidty in the tile to the right
                }
            }
            else if (terrainMap[h][w][0] >= (cutoff / 100.0f)){//If is land and humidity isn't already 0
                if(terrainMap[h][w][pass] > 0.00f){
                  //Code for humidity decrease
                  terrainMap[h + hDir][w + wDir][pass] = terrainMap[h][w][pass] - ((0.0025f * (terrainMap[h][w][0] * 4 +  (1- terrainMap[h][w][1]) * 1))); //Decrease humidty in the tile to the right
                                                                  //Base *   terrainheight       modif  invertet terrain temp    modif
                }
                else{
                  terrainMap[h + hDir][w + wDir][pass] = terrainMap[h][w][pass]; //Set min humidty in the tile to the right
                }
            }
            //debugHumRange(terrainMap[h][w][2]);
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

void calculateHumidity(){
    noiseDetail(octavesRidge, falloffRidge / 10.0f);
    float yoff = 0;
    for (int h = 0; h < height -1; h +=1) {
      float xoff = 0;
      for (int w = 0; w < width - 1; w +=1) {
        float total = (terrainMap[h][w][5] * 0.60) + (terrainMap[h][w][6] * 0.20) + (terrainMap[h][w][7] * 0.20);
        if(rainSmoothing){
           total = lerp(total, noise(xoff, yoff), 0.30);
        }
        if(total > 0.99){
          terrainMap[h][w][2] = 0.99;
        }
        else if(total < 0.00){
          terrainMap[h][w][2] = 0.00;
        }
        else{
          terrainMap[h][w][2] = total;
        }
        xoff += (intensity / 1000.0f);
      }
      yoff += (intensity / 1000.0f);
    }
 
}

public void simulatePressure(){
    //Set initial humidity
    for (int h = 0; h < (height); h++) {
         terrainMap[h][0][3] = 0.50;
    }
    
    for (int h = 0; h < height -1; h +=1) {
      
        for (int w = 0; w < width - 1; w +=1) {
          //println(h + " " + w);
          //Normalising only for every other row
        if(h % 2 == 0 && h != 0 && h != 999){
            float pTop = terrainMap[h - 1][w][3];
            float pMid = terrainMap[h][w][3];
            float pBot = terrainMap[h + 1][w][3];
            
            float flowTopMid = (pTop - pMid) * 0.50;
            float flowBotMid = (pBot - pMid) * 0.50;
            //println(flowTopMid + " " + flowBotMid);
            pTop -= flowTopMid;
            pMid += flowTopMid;
            pBot -= flowBotMid;
            pMid += flowBotMid;
            
            terrainMap[h - 1][w + 1][3] = pTop;
            terrainMap[h][w + 1][3] = pMid;
            terrainMap[h + 1][w + 1][3] = pBot;
          }
          
          //Height/Pressure Distortion for all rows
          //float pTop = terrainMap[h - 1][w][3];
          float pMid = terrainMap[h][w][3];
          //float pBot = terrainMap[h + 1][w][3];
          
          if(terrainMap[h + 1][w][0] > 0.8){
             if(h != 999 && w != 0 && terrainMap[h + 1][w - 1][0] < 0.8){
                  terrainMap[h + 1][w - 1][3] += pMid/2;
              }
             if(h != 0 && w != 0 && terrainMap[h - 1][w + 1][0] < 0.8){
                  terrainMap[h - 1][w + 1][3] += pMid/2;
              }
          }
    }
    }
}
