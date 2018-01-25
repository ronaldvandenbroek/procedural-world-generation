String getSettings() {
    String settings = "Settings: ";
    settings = settings + "| Wireframe: " + wireFrame;
    settings = settings + "| RenderMode: " + renderMode;
    settings = settings + "| Scale: " + scale;
    settings = settings + "| Intensity: " + intensity;
    settings = settings + "| Wlvl: " + waterlvl;
    settings = settings + "| Blvl: " + beachlvl;
    settings = settings + "| Plvl: " + plainlvl;
    settings = settings + "| Flvl: " + forestlvl;
    settings = settings + "| Mlvl: " + mountainlvl;
    settings = settings + "| Slvl: " + snowlvl;
    settings = settings + "| Lod: " + lod;
    settings = settings + "| Falloff: " + falloff;
    return settings;
}

void NewSeed() {
    seed = random(-10000, 10000);
}

color getColor(float terrainHeight) {
    int[] rgb = new int[3];
    if (terrainHeight < waterlvl) {
        return water;
    } else if (terrainHeight < beachlvl) {
        return beach;
    } else if (terrainHeight < plainlvl) {
        return plain;
    } else if (terrainHeight < forestlvl) {
        return forest;
    } else if (terrainHeight < mountainlvl) {
        return mountain;
    } else if (terrainHeight < snowlvl) {
        return snow;
    } else {
        return snow;
    }
}