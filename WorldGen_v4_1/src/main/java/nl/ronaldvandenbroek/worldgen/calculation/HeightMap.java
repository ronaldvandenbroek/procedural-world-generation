package nl.ronaldvandenbroek.worldgen.calculation;

import nl.ronaldvandenbroek.worldgen.NoiseMapGenerator;

public class HeightMap {
    private NoiseMapGenerator noiseMapGenerator;
    private TwoDimensionalArrayUtility mapUtil;
    private String name;
    private int height;
    private int width;
    private int seed;
    private int octaves;
    private float noiseFalloff;
    private float intensity;
    private boolean ridge;
    private float power;
    private float circularFalloff;
    private float weight;
    private float[][] heightMap;

    private HeightMap(String name, float[][] merge, TwoDimensionalArrayUtility mapUtil, float weight) {
        this.name = name;
        this.heightMap = merge;
        this.height = mapUtil.getArrayHeight(merge);
        this.width = mapUtil.getArrayWidth(merge);
        this.seed = -1;
        this.octaves = -1;
        this.noiseFalloff = -1;
        this.intensity = -1;
        this.ridge = false;
        this.power = 0;
        this.circularFalloff = 0;
        this.weight = weight;
        this.mapUtil = mapUtil;
    }

    public HeightMap(String name, NoiseMapGenerator noiseMapGenerator, TwoDimensionalArrayUtility mapUtil, int height, int width, int seed, int octaves, float noiseFalloff, float intensity, boolean ridge, float power, float circularFalloff, float weight) {
        this.name = name;
        this.noiseMapGenerator = noiseMapGenerator;
        this.mapUtil = mapUtil;
        this.height = height;
        this.width = width;
        this.seed = seed;
        this.octaves = octaves;
        this.noiseFalloff = noiseFalloff;
        this.intensity = intensity;
        this.ridge = ridge;
        this.power = power;
        this.circularFalloff = circularFalloff;
        this.weight = weight;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getSeed() {
        return seed;
    }

    public void setSeed(float seed) {
        this.seed = (int) seed;
    }

    public int getOctaves() {
        return octaves;
    }

    public void setOctaves(float octaves) {
        this.octaves = (int) octaves;
    }

    public float getNoiseFalloff() {
        return noiseFalloff;
    }

    public void setNoiseFalloff(float noiseFalloff) {
        this.noiseFalloff = noiseFalloff;
    }

    public float getIntensity() {
        return intensity;
    }

    public void setIntensity(float intensity) {
        this.intensity = intensity;
    }

    public boolean isRidge() {
        return ridge;
    }

    public void setRidge(boolean ridge) {
        this.ridge = ridge;
    }

    public float getPower() {
        return power;
    }

    public void setPower(float power) {
        this.power = power;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public float[][] getHeightMap() {
        return heightMap;
    }

    public void setHeightMap(float[][] heightMap) {
        this.heightMap = heightMap;
    }

    public float getCircularFalloff() {
        return circularFalloff;
    }

    public void setCircularFalloff(float circularFalloff) {
        this.circularFalloff = circularFalloff;
    }

    public void generate() {
        if (noiseMapGenerator != null) {
            heightMap = noiseMapGenerator.generate(height, width, seed, octaves, noiseFalloff, intensity);
        }
        heightMap = mapUtil.map(heightMap, 0, 1);
        if (ridge) {
            heightMap = mapUtil.ridge(heightMap);
        }
        if (power > 0) {
            heightMap = mapUtil.curve(heightMap, power);
        }
        if (circularFalloff > 0) {
            heightMap = mapUtil.circularFalloffAbsolute(heightMap, circularFalloff);
        }
        heightMap = mapUtil.map(heightMap, 0, 1);
    }

    public HeightMap merge(HeightMap toBeMergedMap) {
        float[][] mergedMap = mapUtil.merge(heightMap, toBeMergedMap.getHeightMap(), this.weight);
        float combinedWeight = this.weight + toBeMergedMap.getWeight();
        return new HeightMap("MergedMap", mergedMap, mapUtil, combinedWeight);
    }

    public float[][] finalise() {
        return mapUtil.map(heightMap, 0, 255);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
