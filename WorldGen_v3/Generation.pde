   public void generate(){
    noiseSeed(seed);
    noiseDetail(octaves, falloff / 10.0f);
    terrainMap = new float[height][width][2];
    debugReset();
    
    float yoff = 0;
    for (int h = 0; h < height; h++) {
        float xoff = 0;
        for (int w = 0; w < width; w++) {
            //Heightcalculation
           float pheight = noise(xoff, yoff);
            if (edge){
              pheight -= diamondFalloff(w, h);
            }
            if(terrainCurving){
              pheight = pow((pheight - 0.09), 5) + 0.2;
           } 
            if (pheight > (cutoff / 100.0f)){
              terrainMap[h][w][0] = pheight;
            }
            else{
              terrainMap[h][w][0] = cutoff / 100.0f;
            }
            
            //Tempcalculation
            terrainMap[h][w][1] = (horizontalFalloff(h) /2) - (pheight); //Hotter at the equator but gets colder the higher altitude you get
            
            //Debug logging
            debugHeightRange(terrainMap[h][w][0]);
            debugTempRange(terrainMap[h][w][1]);
            
            xoff += (intensity / 1000.0f);
        }
        yoff += (intensity / 1000.0f);
    }
}

public void seed(){
   seed = (long)random(0, 10000);
}

public float diamondFalloff(int w, int h){
    int wCoord = w - (width / 2);
    int hCoord = h - (height / 2);
    return (abs(wCoord) + abs(hCoord)) / 1000.0;
}

public float horizontalFalloff(int h){
    int hCoord = h - (height / 2);
    return abs(hCoord) / 1000.0;
}