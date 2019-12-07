package nl.ronaldvandenbroek.worldgen.gui;

import nl.ronaldvandenbroek.worldgen.WorldGen;
import nl.ronaldvandenbroek.worldgen.calculation.HeightMap;
import nl.ronaldvandenbroek.worldgen.properties.Config;

public class ControlBuilder {
    public static void HeightMap(ControlGui controlGui, HeightMap heightMap) {
        controlGui.createGUISliderTitle(heightMap.getName() + "HeightMap", false);
        controlGui.createGUISlider(new ControlElementSlider(
                heightMap.getName() + " Seed",
                "seed",
                heightMap,
                heightMap.getSeed(),
                Config.HEIGHT_MAP_SEED_MIN,
                Config.HEIGHT_MAP_SEED_MAX)
        );
        controlGui.createGUISlider(new ControlElementSlider(
                heightMap.getName() + " Noise Octaves",
                "octaves",
                heightMap,
                heightMap.getOctaves(),
                Config.HEIGHT_MAP_OCTAVE_MIN,
                Config.HEIGHT_MAP_OCTAVE_MAX)
        );
        controlGui.createGUISlider(new ControlElementSlider(
                heightMap.getName() + " Noise Intensity",
                "intensity",
                heightMap,
                heightMap.getIntensity(),
                Config.HEIGHT_MAP_INTENSITY_MIN,
                Config.HEIGHT_MAP_INTENSITY_MAX)
        );
        controlGui.createGUISlider(new ControlElementSlider(
                heightMap.getName() + " Noise Falloff",
                "noiseFalloff",
                heightMap,
                heightMap.getNoiseFalloff(),
                Config.HEIGHT_MAP_NOISE_FALLOFF_MIN,
                Config.HEIGHT_MAP_NOISE_FALLOFF_MAX)
        );
        controlGui.createGUISlider(new ControlElementSlider(
                heightMap.getName() + " Circular Falloff",
                "circularFalloff",
                heightMap,
                heightMap.getCircularFalloff(),
                Config.HEIGHT_MAP_CIRCULAR_FALLOFF_MIN,
                Config.HEIGHT_MAP_CIRCULAR_FALLOFF_MAX)
        );
        controlGui.createGUISlider(new ControlElementSlider(
                heightMap.getName() + " Power",
                "power",
                heightMap,
                heightMap.getPower(),
                Config.HEIGHT_MAP_POWER_MIN,
                Config.HEIGHT_MAP_POWER_MAX)
        );
        controlGui.createGUISlider(new ControlElementSlider(
                heightMap.getName() + " Weight",
                "weight",
                heightMap,
                heightMap.getWeight(),
                Config.HEIGHT_MAP_WEIGHT_MIN,
                Config.HEIGHT_MAP_WEIGHT_MAX)
        );
    }

    public static void Menu(ControlGui controlGui, WorldGen worldGen){
        controlGui.createGUIMapButton(new ControlElementButton(
                "HeightMap",
                worldGen,
                0f)
        );
        controlGui.createGUIMapButton(new ControlElementButton(
                "TemperatureMap",
                worldGen,
                1f)
        );
    }
}
