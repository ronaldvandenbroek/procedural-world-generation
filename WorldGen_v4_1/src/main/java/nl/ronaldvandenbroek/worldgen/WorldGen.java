package nl.ronaldvandenbroek.worldgen;

import nl.ronaldvandenbroek.worldgen.calculation.TwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.gui.ControlElementSliderFloat;
import nl.ronaldvandenbroek.worldgen.gui.ControlGui;
import nl.ronaldvandenbroek.worldgen.gui.Presets;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingImageDrawer;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingPerlinNoise;
import processing.core.PApplet;
import processing.core.PImage;

public class WorldGen extends PApplet {
    private static int WIDTH = 1024;
    private static int HEIGHT = 1024;
    public static float intensity1 = 0;

    public static void main(String[] args) {
        PApplet.main("nl.ronaldvandenbroek.worldgen.WorldGen", args);
    }

    public void settings() {
        size(WIDTH, HEIGHT);
    }

    public void setup(){
        Presets presets = new Presets();
        NoiseMapGenerator noiseMapGenerator = new ProcessingPerlinNoise(this);
        ProcessingImageDrawer processingImageDrawer = new ProcessingImageDrawer(this);
        TwoDimensionalArrayUtility mapUtil = new TwoDimensionalArrayUtility();

        ControlGui controlGui = new ControlGui(this);
        controlGui.createGUISliderTitle("HeightMap Configuration", true);
        controlGui.createGUISliderFloat(new ControlElementSliderFloat("Test Variable", "test", presets, presets.getTest(), 1f, 10f));

        float[][] noiseMap = noiseMapGenerator.generate(HEIGHT, WIDTH, 1, 7, 4.5f, 4f);
        mapUtil.map(noiseMap, 0, 1);
        mapUtil.ridge(noiseMap);
        mapUtil.curve(noiseMap, 4);
        mapUtil.circularFalloffAbsolute(noiseMap, 1);
        mapUtil.map(noiseMap, 0, 255);

        //System.out.println(mapUtil.getHighestArrayValue(noiseMap));
        //System.out.println(mapUtil.getLowestArrayValue(noiseMap));

        PImage testImage = processingImageDrawer.draw(noiseMap);
        image(testImage, 0, 0);
    }

    public void draw() {
    }
}
