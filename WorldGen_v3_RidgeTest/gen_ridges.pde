public void gen_ridges() {
  noiseDetail(octaves, falloff / 10.0f);
    float yoff = 0;
    for (int h = 0; h < height; h++) {
        float xoff = 0;
        for (int w = 0; w < width; w++) {
            //Heightcalculation
           float pheight = 1 - abs((noise(xoff, yoff) - 0.5) * -1);
           pheight = pow((pheight - 0.09), 5) + 0.2;
           
            pheight -= circularFalloff(w, h);
              
            terrainMap[h][w] = pheight;
            
            xoff += (intensity / 1000.0f);
        }
        yoff += (intensity / 1000.0f);
    }
    draw_terrainMap();
}

public float circularFalloff(int w, int h){
    int wCoord = w - (width / 2);
    int hCoord = h - (height / 2);
    return sqrt(sq(wCoord) + sq(hCoord)) / 600.0;
}