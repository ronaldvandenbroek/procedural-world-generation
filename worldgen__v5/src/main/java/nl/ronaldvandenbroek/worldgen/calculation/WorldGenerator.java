package nl.ronaldvandenbroek.worldgen.calculation;

import nl.ronaldvandenbroek.worldgen.calculation.array.ITwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.calculation.noise.INoiseMapGenerator;
import nl.ronaldvandenbroek.worldgen.properties.Config;
import nl.ronaldvandenbroek.worldgen.properties.Preset;

import java.util.ArrayList;
import java.util.List;

public class WorldGenerator {
    // Variables
    private float currentMap;
    private float currentTime;

    // Utilities
    private INoiseMapGenerator noiseMapGenerator;
    private ITwoDimensionalArrayUtility mapUtil;

    // Generated maps
    private List<HeightMap> heightMapLayers;
    private HeightMap heightMap;
    private TemperatureMap temperatureMap;

    public WorldGenerator(INoiseMapGenerator noiseMapGenerator, ITwoDimensionalArrayUtility mapUtil) {
        this.noiseMapGenerator = noiseMapGenerator;
        this.mapUtil = mapUtil;
        this.currentMap = Config.DEFAULT_MAP;

        createDefaultMaps();
    }

    public void incrementCurrentTime() {
        this.currentTime += Preset.HEIGHT_MAP_BASE_INTENSITY / Config.PERLIN_INTENSITY_MODIFIER * 2;
    }

    public void setCurrentMap(float currentMap) {
        this.currentMap = currentMap;
    }

    public List<HeightMap> getHeightMapLayers() {
        return heightMapLayers;
    }

    public TemperatureMap getTemperatureMap() {
        return temperatureMap;
    }

    public void generateMaps() {
        heightMap = null;

        // Combine all heightMaps
        for (HeightMap heightMapLayer : heightMapLayers) {
            heightMapLayer.setTime(currentTime);
            heightMapLayer.generate();
            if (heightMap == null) {
                heightMap = heightMapLayer;
            } else {
                heightMap = heightMap.merge(heightMapLayer);
            }
        }

        // Generate final heightMap
        if (heightMap != null) {
            heightMap.setCircularFalloff(Preset.HEIGHT_MAP_TOTAL_CIRCULAR_FALLOFF);
            heightMap.generate();

            temperatureMap.generate(heightMap);
        }
    }

    public float[][] finalizeSelectedMap() {
        switch ((int) currentMap) {
            case 1:
                return temperatureMap.finalise();
            default: //also 0
                return heightMap.finalise();
        }
    }

    private void createDefaultMaps() {
        heightMapLayers = new ArrayList<>();

        heightMapLayers.add(new HeightMap(
                Preset.HEIGHT_MAP_BASE_NAME,
                noiseMapGenerator,
                mapUtil,
                Config.IMAGE_HEIGHT,
                Config.IMAGE_WIDTH,
                Preset.HEIGHT_MAP_BASE_SEED,
                Config.TIME,
                Preset.HEIGHT_MAP_BASE_OCTAVE,
                Preset.HEIGHT_MAP_BASE_NOISE_FALLOFF,
                Preset.HEIGHT_MAP_BASE_INTENSITY,
                Preset.HEIGHT_MAP_BASE_RIDGE,
                Preset.HEIGHT_MAP_BASE_POWER,
                Preset.HEIGHT_MAP_BASE_CIRCULAR_FALLOFF,
                Preset.HEIGHT_MAP_BASE_WEIGHT)
        );
//        heightMapLayers.add(new HeightMap(
//                Preset.HEIGHT_MAP_RIDGE_NAME,
//                noiseMapGenerator,
//                mapUtil,
//                Config.IMAGE_HEIGHT,
//                Config.IMAGE_WIDTH,
//                Preset.HEIGHT_MAP_RIDGE_SEED,
//                Config.TIME,
//                Preset.HEIGHT_MAP_RIDGE_OCTAVE,
//                Preset.HEIGHT_MAP_RIDGE_NOISE_FALLOFF,
//                Preset.HEIGHT_MAP_RIDGE_INTENSITY,
//                Preset.HEIGHT_MAP_RIDGE_RIDGE,
//                Preset.HEIGHT_MAP_RIDGE_POWER,
//                Preset.HEIGHT_MAP_RIDGE_CIRCULAR_FALLOFF,
//                Preset.HEIGHT_MAP_RIDGE_WEIGHT)
//        );
        temperatureMap = new TemperatureMap(
                mapUtil,
                Preset.TEMPERATURE_MAP_EQUATOR_OFFSET,
                Preset.TEMPERATURE_MAP_LATITUDE_STRENGTH,
                Preset.TEMPERATURE_MAP_ALTITUDE_STRENGTH,
                Preset.TEMPERATURE_MAP_GLOBAL_MODIFIER
        );
    }
}
