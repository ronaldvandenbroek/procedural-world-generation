   public void generate(){
    noiseSeed(seed);
    noiseDetail(octaves, falloff / 10.0f);
    terrainMap = new float[height][width][3];
    debugReset();
    
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

public float horizontalFalloff(int h){
    int hCoord = h - (height / 2);
    return abs(hCoord) / 180.0;
}


public void calculateHeightAndTemp() {
float yoff = 0;
    for (int h = 0; h < height; h++) {
        float xoff = 0;
        for (int w = 0; w < width; w++) {
            //Heightcalculation
           float pheight = noise(xoff, yoff);
            if (edge){
              pheight -= circularFalloff(w, h);
            }
            if(terrainCurving){
              pheight = pow((pheight - 0.09), 5) + 0.2;
           } 
            if (pheight > (cutoff / 100.0f)){
              terrainMap[h][w][0] = pheight;
              terrainMap[h][w][1] = 1.1 - (lerp(horizontalFalloff(h), pheight, 0.65)); //Hotter at the equator but gets colder the higher altitude you get
            }
            else{
              terrainMap[h][w][0] = cutoff / 100.0f;
              terrainMap[h][w][1] = 0.8 - (lerp(horizontalFalloff(h), pheight, 0.7)); //Water temp (not important for calculations, just used for visual
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
    for (int h = 0; h < (height - 1); h++) {
        terrainMap[h][0][2] = 1.00;
    }
    
    //Move humidity from left to right
    for (int h = 0; h < (height - 1); h++) {
        for (int w = 0; w < (width - 1); w++) {
            if(terrainMap[h][w][0] <= (cutoff / 100.0f)){//If is water and humidity isn't already max
                if(terrainMap[h][w][2] < 1.00f){
                  terrainMap[h][w + 1][2] = terrainMap[h][w][2] + 0.001f; //Increase humidty in the tile to the right
                }
                else{
                  terrainMap[h][w + 1][2] = terrainMap[h][w][2]; //Set max humidty in the tile to the right
                }
            }
            else if (terrainMap[h][w][0] >= (cutoff / 100.0f)){//If is land and humidity isn't already 0
                if(terrainMap[h][w][2] > 0.00f){
                  //Code for humidity decrease
                  terrainMap[h][w + 1][2] = terrainMap[h][w][2] - (0.002f * (terrainMap[h][w][0] * 4 +  (1- terrainMap[h][w][1]) * 1)); //Decrease humidty in the tile to the right
                                                                  //Base *   terrainheight       modif  invertet terrain temp    modif
                }
                else{
                  //println(w);
                  terrainMap[h][w + 1][2] = terrainMap[h][w][2]; //Set min humidty in the tile to the right
                }
            }
            debugHumRange(terrainMap[h][w][2]);
        }
    }
}