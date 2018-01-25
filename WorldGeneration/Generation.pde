void Generate() {
    noiseSeed((long)seed);
    noiseDetail(lod, falloff);

    cols = w / scale;
    rows = h / scale;
    heightMap = new float[cols][rows];
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
        float xoff = 0;
        for (int x = 0; x < cols; x++) {
            float initialHeight = map(noise(xoff + seed, yoff + seed), 0 , 1, 0 , 255);
            heightMap[x][y] = initialHeight;
            
            xoff += intensity;
        }
        yoff += intensity;
    }
}