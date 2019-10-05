package nl.ronaldvandenbroek.worldgen.gui;

import nl.ronaldvandenbroek.worldgen.calculation.HeightMap;

public class ControlBuilder {
    public static void HeightMap(ControlGui controlGui, HeightMap heightMap, String name) {
        controlGui.createGUISliderTitle(name, false);
        controlGui.createGUISliderInteger(new ControlElementSliderInteger("Seed", "seed", heightMap, heightMap.getSeed(), 0, 100));
        controlGui.createGUISliderInteger(new ControlElementSliderInteger("Noise Octaves", "octaves", heightMap, heightMap.getOctaves(), 1, 15));
        controlGui.createGUISliderFloat(new ControlElementSliderFloat("Noise Intensity", "intensity", heightMap, heightMap.getIntensity(), 1f, 30f));
        controlGui.createGUISliderFloat(new ControlElementSliderFloat("Noise Falloff", "noiseFalloff", heightMap, heightMap.getNoiseFalloff(), 0f, 10f));
        controlGui.createGUISliderFloat(new ControlElementSliderFloat("Circular Falloff", "circularFalloff", heightMap, heightMap.getCircularFalloff(), 0f, 1f));
        controlGui.createGUISliderFloat(new ControlElementSliderFloat("Power", "power", heightMap, heightMap.getPower(), 0f, 50f));
        controlGui.createGUISliderFloat(new ControlElementSliderFloat("Weight", "weight", heightMap, heightMap.getWeight(), 0f, 1f));
    }
}
