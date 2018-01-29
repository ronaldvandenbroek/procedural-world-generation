public void gen_smooth_perlin() {
  noiseDetail(octaves, falloff / 10.0f);
    float yoff = 0;
    for (int h = 0; h < height; h++) {
        float xoff = 0;
        for (int w = 0; w < width; w++) {
           float pheight = noise(xoff, yoff);
            terrainMap[h][w] = pheight;
            xoff += (intensity / 1000.0f);
        }
        yoff += (intensity / 1000.0f);
    }
    draw_terrainMap();
}