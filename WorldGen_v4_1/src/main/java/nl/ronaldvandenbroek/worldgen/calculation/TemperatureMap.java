package nl.ronaldvandenbroek.worldgen.calculation;

public class TemperatureMap {
    private ITwoDimensionalArrayUtility mapUtil;
    private int equatorOffset;
    private float latitudeStrength;
    private float altitudeStrength;
    private float globalModifier;
    private float[][] temperatureMap;

    public TemperatureMap(ITwoDimensionalArrayUtility mapUtil, int equatorOffset, float latitudeStrength, float altitudeStrength, float globalModifier) {
        this.mapUtil = mapUtil;
        this.equatorOffset = equatorOffset;
        this.latitudeStrength = latitudeStrength;
        this.altitudeStrength = altitudeStrength;
        this.globalModifier = globalModifier;
    }

    public void generate(HeightMap heightMapObject) {
        float[][] heightTemperatureMap = mapUtil.invert(heightMapObject.getHeightMap());

        temperatureMap = mapUtil.verticalFalloffAbsolute(heightTemperatureMap, equatorOffset);
        temperatureMap = mapUtil.merge(temperatureMap, heightTemperatureMap, latitudeStrength, altitudeStrength);
        temperatureMap = mapUtil.add(temperatureMap, 0, 1, globalModifier);

        System.out.println(mapUtil.getHighestArrayValue(temperatureMap));
        System.out.println(mapUtil.getLowestArrayValue(temperatureMap));
    }

    public float[][] finalise() {
        return mapUtil.map(temperatureMap, 0, 255);
    }

    public float getLatitudeStrength() {
        return latitudeStrength;
    }

    public void setLatitudeStrength(float latitudeStrength) {
        this.latitudeStrength = latitudeStrength;
    }

    public float getAltitudeStrength() {
        return altitudeStrength;
    }

    public void setAltitudeStrength(float altitudeStrength) {
        this.altitudeStrength = altitudeStrength;
    }

    public float getGlobalModifier() {
        return globalModifier;
    }

    public void setGlobalModifier(float globalModifier) {
        this.globalModifier = globalModifier;
    }

    public int getEquatorOffset() {
        return equatorOffset;
    }

    public void setEquatorOffset(float equatorOffset) {
        this.equatorOffset = (int)equatorOffset;
    }
}
