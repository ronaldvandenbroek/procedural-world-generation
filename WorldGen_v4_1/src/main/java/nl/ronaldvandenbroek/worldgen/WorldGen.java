package nl.ronaldvandenbroek.worldgen;

import nl.ronaldvandenbroek.worldgen.calculation.array.ITwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.calculation.array.TwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.calculation.HeightMap;
import nl.ronaldvandenbroek.worldgen.calculation.TemperatureMap;
import nl.ronaldvandenbroek.worldgen.gui.ControlBuilder;
import nl.ronaldvandenbroek.worldgen.gui.ControlGui;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingImageDrawer;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingPerlinNoise;
import nl.ronaldvandenbroek.worldgen.properties.Config;
import nl.ronaldvandenbroek.worldgen.properties.Preset;
import nl.ronaldvandenbroek.worldgen.properties.PropertyLoader;
import nl.ronaldvandenbroek.worldgen.utility.CodeTimer;
import processing.core.PApplet;
import processing.core.PImage;

import java.util.ArrayList;
import java.util.List;

public class WorldGen extends PApplet {
    private float currentMap;
    private float currentTime;
    private boolean passTime;

    // Utilities
    private NoiseMapGenerator noiseMapGenerator;
    private ProcessingImageDrawer processingImageDrawer;
    private ITwoDimensionalArrayUtility mapUtil;
    private ControlGui controlGui;
    private CodeTimer codeTimer;

    // Generated maps
    private List<HeightMap> heightMapLayers;
    private HeightMap heightMap;
    private TemperatureMap temperatureMap;

    public static void main(String[] args) {
        PropertyLoader.load(Config.class, "config.properties");
        PropertyLoader.load(Preset.class, "preset.properties");

        PApplet.main("nl.ronaldvandenbroek.worldgen.WorldGen", args);
    }

    public void settings() {
        size(Config.WIDTH, Config.HEIGHT);
    }

    public void setup() {
        // Setup exit handler
        Runtime.getRuntime().addShutdownHook(new Thread(this::stop));

        // Setup config variables
        currentMap = Config.DEFAULT_MAP;
        passTime = Config.ENABLE_TIME_LAPSE;
        currentTime = Config.TIME;

        // Setup utilities
        codeTimer = new CodeTimer("TickSpeed");
        noiseMapGenerator = new ProcessingPerlinNoise(this);
        processingImageDrawer = new ProcessingImageDrawer(this);
        mapUtil = new TwoDimensionalArrayUtility();

        // Setup GUI
        controlGui = new ControlGui(this);
        controlGui.createGUISliderTitle("WorldGen Configuration", true);
        ControlBuilder.Menu(controlGui, this);

        // Generate the preset map
        codeTimer.start();
        createDefaultMaps();
    }

    public void draw() {
        if (passTime) {
            codeTimer.round();
            currentTime += Preset.HEIGHT_MAP_BASE_INTENSITY / Config.PERLIN_INTENSITY_MODIFIER * 2;
            for (HeightMap heightMapLayer : heightMapLayers) {
                heightMapLayer.setTime(currentTime);
            }
            generateMaps();
        }
    }

    public void stop() {
        codeTimer.end();
    }

    public void mouseReleased() {
        generateMaps();
        // System.out.println("Mouse Released");
    }

    public void menuPressed(float value){
        // System.out.println("Menu Pressed: " + value);
        currentMap = value;

        drawMaps();
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
                currentTime,
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
                currentTime,
                Preset.HEIGHT_MAP_RIDGE_OCTAVE,
                Preset.HEIGHT_MAP_RIDGE_NOISE_FALLOFF,
                Preset.HEIGHT_MAP_RIDGE_INTENSITY,
                Preset.HEIGHT_MAP_RIDGE_RIDGE,
                Preset.HEIGHT_MAP_RIDGE_POWER,
                Preset.HEIGHT_MAP_RIDGE_CIRCULAR_FALLOFF,
                Preset.HEIGHT_MAP_RIDGE_WEIGHT)
        );
        temperatureMap = new TemperatureMap(
                mapUtil,
                Preset.TEMPERATURE_MAP_EQUATOR_OFFSET,
                Preset.TEMPERATURE_MAP_LATITUDE_STRENGTH,
                Preset.TEMPERATURE_MAP_ALTITUDE_STRENGTH,
                Preset.TEMPERATURE_MAP_GLOBAL_MODIFIER
        );

        for (HeightMap heightMap : heightMapLayers) {
            ControlBuilder.HeightMap(controlGui, heightMap);
        }
        ControlBuilder.TemperatureMap(controlGui, temperatureMap);

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

            temperatureMap.generate(heightMap);

            drawMaps();
        }
    }

    private void drawMaps() {
        PImage displayImage;
        switch ((int)currentMap){
            case 1:
                displayImage = processingImageDrawer.draw(temperatureMap.finalise());
                break;
            default: //also 0
                displayImage = processingImageDrawer.draw(heightMap.finalise());
        }

        if (displayImage != null) {
            image(displayImage, 0, 0);
        }
    }
}
