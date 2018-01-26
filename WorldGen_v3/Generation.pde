   public void generate(){
    noiseSeed(seed);
    noiseDetail(octaves, falloff / 10.0f);
    
    loadPixels();
    float yoff = 0;
    for (int h = 0; h < height; h++) {
        float xoff = 0;
        for (int w = 0; w < width; w++) {
            float pheight = noise(xoff, yoff);
            if (edge){
              pheight -= falloff(w, h);
            }
           
            //println(pheight);
            if (pheight > (cutoff / 100.0f)){
              pixels[h * 1000 + w] = color(255);
            }
            else{
              pixels[h * 1000 + w] = color(0);
            }
            xoff += (intensity / 1000.0f);
        }
        yoff += (intensity / 1000.0f);
    }
    updatePixels();
}

public void seed(){
   seed = (long)random(0, 10000);
}

public float falloff(int w, int h){
    int wCoord = w - (width / 2);
    int hCoord = h - (height / 2);
    
    float edgeFalloff = (abs(wCoord) + abs(hCoord)) / 1000;
    println (edgeFalloff);
    return edgeFalloff;
}
int offset;