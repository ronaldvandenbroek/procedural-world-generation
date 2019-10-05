package nl.ronaldvandenbroek.worldgen;

import nl.ronaldvandenbroek.worldgen.calculation.HeightMap;
import nl.ronaldvandenbroek.worldgen.calculation.TwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.gui.ControlBuilder;
import nl.ronaldvandenbroek.worldgen.gui.ControlGui;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingImageDrawer;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingPerlinNoise;
import processing.core.PApplet;
import processing.core.PImage;

public class WorldGen extends PApplet {
    private static int WIDTH = 1024;
    private static int HEIGHT = 1024;

    private NoiseMapGenerator noiseMapGenerator;
    private ProcessingImageDrawer processingImageDrawer;
    private TwoDimensionalArrayUtility mapUtil;
    private ControlGui controlGui;

    boolean generatedControls = false;

    public static void main(String[] args) {
        PApplet.main("nl.ronaldvandenbroek.worldgen.WorldGen", args);
    }

    public void settings() {
        size(WIDTH, HEIGHT);
    }

    public void setup(){
        noiseMapGenerator = new ProcessingPerlinNoise(this);
        processingImageDrawer = new ProcessingImageDrawer(this);
        mapUtil = new TwoDimensionalArrayUtility();

        controlGui = new ControlGui(this);
        controlGui.createGUISliderTitle("HeightMap Configuration", true);

        generateHeightMaps();
    }

    public void draw() {
    }

    public void mouseReleased() {
        generateHeightMaps();
        System.out.println("Mouse Released");
    }

    public void generateHeightMaps(){
        HeightMap heightMapBase = new HeightMap(noiseMapGenerator, mapUtil, HEIGHT, WIDTH, 1, 7, 4.5f, 4f, false, 0, 0, 0.8f);
        if (!generatedControls){
            ControlBuilder.HeightMap(controlGui, heightMapBase, "Base HeightMap");
        }
        HeightMap heightMapRidge = new HeightMap(noiseMapGenerator, mapUtil, HEIGHT, WIDTH, 1, 7, 4.5f, 4f, true, 5, 0, 1f);
        HeightMap heightMapTotal = heightMapBase.merge(heightMapRidge);
        heightMapTotal.setCircularFalloff(1f);
        heightMapTotal.generate();

        PImage testImage = processingImageDrawer.draw(heightMapTotal.finalise());
        image(testImage, 0, 0);
        generatedControls = true;
    }

}
