package nl.ronaldvandenbroek.worldgen;

import controlP5.ControlP5;
import nl.ronaldvandenbroek.worldgen.calculation.TwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingImageDrawer;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingPerlinNoise;
import processing.core.PApplet;
import processing.core.PImage;

public class WorldGen extends PApplet {
    private static int WIDTH = 1024;
    private static int HEIGHT = 1024;

    public static ControlP5 gui;

    public static void main(String[] args) {
        PApplet.main("nl.ronaldvandenbroek.worldgen.WorldGen", args);
    }

    public void settings() {
        size(WIDTH, HEIGHT);
    }

    public void setup(){
        NoiseMapGenerator noiseMapGenerator = new ProcessingPerlinNoise(this);
        ProcessingImageDrawer processingImageDrawer = new ProcessingImageDrawer(this);

        float[][] noiseMap = noiseMapGenerator.generate(HEIGHT, WIDTH, 0, 7, 4.5f, 4f);
        TwoDimensionalArrayUtility.map(noiseMap, 0, 255);
        PImage testImage = processingImageDrawer.draw(noiseMap);
        image(testImage, 0, 0);
    }

    public void draw() {
    }
}
