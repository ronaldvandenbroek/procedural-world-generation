package nl.ronaldvandenbroek.worldgen;

import controlP5.ControlP5;
import nl.ronaldvandenbroek.worldgen.calculation.TwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.gui.ControlElementSliderFloat;
import nl.ronaldvandenbroek.worldgen.gui.ControlElementSliderInteger;
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

        ControlGui controlGui = new ControlGui(this);
        controlGui.createGUISliderTitle("HeightMap Configuration", true);
        controlGui.createGUISliderFloat(new ControlElementSliderFloat("Test Variable", "test", presets, presets.getTest(), 1f, 10f));

        float[][] noiseMap = noiseMapGenerator.generate(HEIGHT, WIDTH, 0, 7, 4.5f, 4f);
        //TwoDimensionalArrayUtility.map(noiseMap, 0, 255);
        //TwoDimensionalArrayUtility.curve(noiseMap, 10);
        TwoDimensionalArrayUtility.ridge(noiseMap);
        //TwoDimensionalArrayUtility.circularFalloff(noiseMap, 1f);
        TwoDimensionalArrayUtility.map(noiseMap, 0, 255);
        PImage testImage = processingImageDrawer.draw(noiseMap);
        image(testImage, 0, 0);
    }

    public void draw() {
    }
}
