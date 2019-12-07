package nl.ronaldvandenbroek.worldgen.calculation;

public class TemperatureMap {
    private TwoDimensionalArrayUtility mapUtil;
    private int equatorOffset;
    private int latitudeStrength;
    private int altitudeStrength;
    private int globalModifier;
    private float[][] temperatureMap;

    public TemperatureMap(TwoDimensionalArrayUtility mapUtil, int equatorOffset, int latitudeStrength, int altitudeStrength, int globalModifier) {
        this.mapUtil = mapUtil;
        this.equatorOffset = equatorOffset;
        this.latitudeStrength = latitudeStrength;
        this.altitudeStrength = altitudeStrength;
        this.globalModifier = globalModifier;
    }

    public void generate(HeightMap heightMapObject) {
        float[][] heightMap = heightMapObject.getHeightMap();

        temperatureMap = mapUtil.verticalFalloffPercentile(heightMap, equatorOffset);
    }

    public float[][] finalise() {
        return mapUtil.map(temperatureMap, 0, 255);
    }

    public int getLatitudeStrength() {
        return latitudeStrength;
    }

    public void setLatitudeStrength(float latitudeStrength) {
        this.latitudeStrength = (int)latitudeStrength;
    }

    public int getAltitudeStrength() {
        return altitudeStrength;
    }

    public void setAltitudeStrength(float altitudeStrength) {
        this.altitudeStrength = (int)altitudeStrength;
    }

    public int getGlobalModifier() {
        return globalModifier;
    }

    public void setGlobalModifier(float globalModifier) {
        this.globalModifier = (int)globalModifier;
    }

    public int getEquatorOffset() {
        return equatorOffset;
    }

    public void setEquatorOffset(float equatorOffset) {
        this.equatorOffset = (int)equatorOffset;
    }
}
