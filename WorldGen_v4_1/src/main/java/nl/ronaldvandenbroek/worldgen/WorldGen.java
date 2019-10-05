package nl.ronaldvandenbroek.worldgen;

import nl.ronaldvandenbroek.worldgen.calculation.HeightMap;
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

        HeightMap heightMapBase = new HeightMap(noiseMapGenerator, mapUtil, HEIGHT, WIDTH, 1, 7, 4.5f, 4f, false, 0, 0, 0.8f);
        HeightMap heightMapRidge = new HeightMap(noiseMapGenerator, mapUtil, HEIGHT, WIDTH, 1, 7, 4.5f, 4f, true, 5, 0, 1f);
        HeightMap heightMapTotal = heightMapBase.merge(heightMapRidge);
        heightMapTotal.setCircularFalloff(1f);
        heightMapTotal.generate();

        PImage testImage = processingImageDrawer.draw(heightMapTotal.finalise());
        image(testImage, 0, 0);
    }

    public void draw() {
    }
}
