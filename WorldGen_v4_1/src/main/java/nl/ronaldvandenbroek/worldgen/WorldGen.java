package nl.ronaldvandenbroek.worldgen;

import nl.ronaldvandenbroek.worldgen.calculation.HeightMap;
import nl.ronaldvandenbroek.worldgen.calculation.TwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.gui.ControlBuilder;
import nl.ronaldvandenbroek.worldgen.gui.ControlGui;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingImageDrawer;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingPerlinNoise;
import nl.ronaldvandenbroek.worldgen.properties.Config;
import nl.ronaldvandenbroek.worldgen.properties.Preset;
import nl.ronaldvandenbroek.worldgen.properties.PropertyLoader;
import processing.core.PApplet;
import processing.core.PImage;

import java.util.ArrayList;
import java.util.List;

public class WorldGen extends PApplet {
    // Utilities
    private NoiseMapGenerator noiseMapGenerator;
    private ProcessingImageDrawer processingImageDrawer;
    private TwoDimensionalArrayUtility mapUtil;
    private ControlGui controlGui;

    // Generated maps
    private List<HeightMap> heightMapLayers;
    private HeightMap heightMap;

    public static void main(String[] args) {
        PropertyLoader.load(Config.class, "config.properties");
        PropertyLoader.load(Preset.class, "preset.properties");
        PApplet.main("nl.ronaldvandenbroek.worldgen.WorldGen", args);
    }

    public void settings() {
        size(Config.WIDTH, Config.HEIGHT);
    }

    public void setup() {
        noiseMapGenerator = new ProcessingPerlinNoise(this);
        processingImageDrawer = new ProcessingImageDrawer(this);
        mapUtil = new TwoDimensionalArrayUtility();

        controlGui = new ControlGui(this);
        controlGui.createGUISliderTitle("HeightMap Configuration", true);

        createDefaultMaps();
    }

    public void draw() {
    }

    public void mouseReleased() {
        generateMaps();
        //System.out.println("Mouse Released");
    }

    private void createDefaultMaps() {
        heightMapLayers = new ArrayList<>();

        heightMapLayers.add(new HeightMap(
                Preset.HEIGHT_MAP_BASE_NAME,
                noiseMapGenerator,
                mapUtil,
                Config.HEIGHT,
                Config.WIDTH,
                Preset.HEIGHT_MAP_BASE_SEED,
                Preset.HEIGHT_MAP_BASE_OCTAVE,
                Preset.HEIGHT_MAP_BASE_NOISE_FALLOFF,
                Preset.HEIGHT_MAP_BASE_INTENSITY,
                Preset.HEIGHT_MAP_BASE_RIDGE,
                Preset.HEIGHT_MAP_BASE_POWER,
                Preset.HEIGHT_MAP_BASE_CIRCULAR_FALLOFF,
                Preset.HEIGHT_MAP_BASE_WEIGHT)
        );
        heightMapLayers.add(new HeightMap(
                Preset.HEIGHT_MAP_RIDGE_NAME,
                noiseMapGenerator,
                mapUtil,
                Config.HEIGHT,
                Config.WIDTH,
                Preset.HEIGHT_MAP_RIDGE_SEED,
                Preset.HEIGHT_MAP_RIDGE_OCTAVE,
                Preset.HEIGHT_MAP_RIDGE_NOISE_FALLOFF,
                Preset.HEIGHT_MAP_RIDGE_INTENSITY,
                Preset.HEIGHT_MAP_RIDGE_RIDGE,
                Preset.HEIGHT_MAP_RIDGE_POWER,
                Preset.HEIGHT_MAP_RIDGE_CIRCULAR_FALLOFF,
                Preset.HEIGHT_MAP_RIDGE_WEIGHT)
        );

        for (HeightMap heightMap : heightMapLayers) {
            ControlBuilder.HeightMap(controlGui, heightMap);
        }

        generateMaps();
    }

    private void generateMaps() {
        heightMap = null;

        // Combine all heightMaps
        for (HeightMap heightMapLayer : heightMapLayers) {
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
            heightMap.finalise();

            drawMaps();
        }
    }

    private void drawMaps() {
        PImage testImage = processingImageDrawer.draw(heightMap.getHeightMap());
        image(testImage, 0, 0);
    }
}
