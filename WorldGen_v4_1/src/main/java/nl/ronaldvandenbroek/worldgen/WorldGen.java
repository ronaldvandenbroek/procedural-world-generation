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
    private NoiseMapGenerator noiseMapGenerator;
    private ProcessingImageDrawer processingImageDrawer;
    private TwoDimensionalArrayUtility mapUtil;
    private ControlGui controlGui;

    private List<HeightMap> heightMaps;

    public static void main(String[] args) {
        PropertyLoader.load(Config.class, "config.properties");
        PropertyLoader.load(Preset.class, "preset.properties");
        PApplet.main("nl.ronaldvandenbroek.worldgen.WorldGen", args);
    }

    public void settings() {
        size(Config.WIDTH, Config.HEIGHT);
    }

    public void setup() {
        heightMaps = new ArrayList<>();
        noiseMapGenerator = new ProcessingPerlinNoise(this);
        processingImageDrawer = new ProcessingImageDrawer(this);
        mapUtil = new TwoDimensionalArrayUtility();

        controlGui = new ControlGui(this);
        controlGui.createGUISliderTitle("HeightMap Configuration", true);

        createDefaultHeightMaps();
    }

    public void draw() {
    }

    public void mouseReleased() {
        generateHeightMaps();
        //System.out.println("Mouse Released");
    }

    private void createDefaultHeightMaps() {
        heightMaps.add(new HeightMap(
                Preset.HEIGHT_MAP_BASE_NAME,
                noiseMapGenerator,
                mapUtil,
                Config.HEIGHT,
                Config.WIDTH,
                Preset.HEIGHT_MAP_BASE_SEED,
                Preset.HEIGHT_MAP_BASE_OCTAVE,
                Preset.HEIGHT_MAP_BASE_NOISE_FALLOFF ,
                Preset.HEIGHT_MAP_BASE_INTENSITY,
                Preset.HEIGHT_MAP_BASE_RIDGE,
                Preset.HEIGHT_MAP_BASE_POWER,
                Preset.HEIGHT_MAP_BASE_CIRCULAR_FALLOFF,
                Preset.HEIGHT_MAP_BASE_WEIGHT)
        );
        heightMaps.add(new HeightMap(
                Preset.HEIGHT_MAP_RIDGE_NAME,
                noiseMapGenerator,
                mapUtil,
                Config.HEIGHT,
                Config.WIDTH,
                Preset.HEIGHT_MAP_RIDGE_SEED,
                Preset.HEIGHT_MAP_RIDGE_OCTAVE,
                Preset.HEIGHT_MAP_RIDGE_NOISE_FALLOFF ,
                Preset.HEIGHT_MAP_RIDGE_INTENSITY,
                Preset.HEIGHT_MAP_RIDGE_RIDGE,
                Preset.HEIGHT_MAP_RIDGE_POWER,
                Preset.HEIGHT_MAP_RIDGE_CIRCULAR_FALLOFF,
                Preset.HEIGHT_MAP_RIDGE_WEIGHT)
        );

        for (HeightMap heightMap : heightMaps) {
            ControlBuilder.HeightMap(controlGui, heightMap);
        }

        generateHeightMaps();
    }

    private void generateHeightMaps() {
        // Combine all heightMaps
        HeightMap heightMapTotal = null;
        for (HeightMap heightMap : heightMaps) {
            heightMap.generate();
            if(heightMapTotal == null){
                heightMapTotal = heightMap;
            }
            else {
                heightMapTotal = heightMapTotal.merge(heightMap);
            }
        }

        if (heightMapTotal != null){
            // Generate final heightMap
            heightMapTotal.setCircularFalloff(Preset.HEIGHT_MAP_TOTAL_CIRCULAR_FALLOFF);
            heightMapTotal.generate();

            PImage testImage = processingImageDrawer.draw(heightMapTotal.finalise());
            image(testImage, 0, 0);
        }
    }
}
