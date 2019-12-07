package nl.ronaldvandenbroek.worldgen.gui;

import nl.ronaldvandenbroek.worldgen.calculation.HeightMap;

public class ControlBuilder {
    public static void HeightMap(ControlGui controlGui, HeightMap heightMap) {
        controlGui.createGUISliderTitle(heightMap.getName() + "HeightMap", false);
        controlGui.createGUISlider(new ControlElementSlider(heightMap.getName() + " Seed", "seed", heightMap, heightMap.getSeed(), 0f, 100f));
        controlGui.createGUISlider(new ControlElementSlider(heightMap.getName() + " Noise Octaves", "octaves", heightMap, heightMap.getOctaves(), 1f, 15f));
        controlGui.createGUISlider(new ControlElementSlider(heightMap.getName() + " Noise Intensity", "intensity", heightMap, heightMap.getIntensity(), 1f, 30f));
        controlGui.createGUISlider(new ControlElementSlider(heightMap.getName() + " Noise Falloff", "noiseFalloff", heightMap, heightMap.getNoiseFalloff(), 0f, 10f));
        controlGui.createGUISlider(new ControlElementSlider(heightMap.getName() + " Circular Falloff", "circularFalloff", heightMap, heightMap.getCircularFalloff(), 0f, 1f));
        controlGui.createGUISlider(new ControlElementSlider(heightMap.getName() + " Power", "power", heightMap, heightMap.getPower(), 0f, 50f));
        controlGui.createGUISlider(new ControlElementSlider(heightMap.getName() + " Weight", "weight", heightMap, heightMap.getWeight(), 0f, 1f));
    }
}
