package nl.ronaldvandenbroek.worldgen;

import nl.ronaldvandenbroek.worldgen.calculation.WorldGenerator;
import nl.ronaldvandenbroek.worldgen.calculation.array.TwoDimensionalArrayUtility;
import nl.ronaldvandenbroek.worldgen.calculation.noise.simplex.SimplexNoise;
import nl.ronaldvandenbroek.worldgen.processing.IProcessingImageDrawer;
import nl.ronaldvandenbroek.worldgen.processing.ProcessingImageDrawer;
import nl.ronaldvandenbroek.worldgen.processing.gui.ControlBuilder;
import nl.ronaldvandenbroek.worldgen.processing.gui.ControlGui;
import nl.ronaldvandenbroek.worldgen.properties.Config;
import nl.ronaldvandenbroek.worldgen.properties.Preset;
import nl.ronaldvandenbroek.worldgen.properties.PropertyLoader;
import nl.ronaldvandenbroek.worldgen.utility.codetimer.CodeTimer;
import nl.ronaldvandenbroek.worldgen.utility.codetimer.ICodeTimer;
import processing.core.PApplet;
import processing.core.PImage;

public class WorldGen extends PApplet {
    private boolean passTime;

    // Utilities
    private IProcessingImageDrawer processingImageDrawer;
    private ICodeTimer codeTimer;
    private WorldGenerator worldGenerator;

    public static void main(String[] args) {
        // Load config en preset properties
        PropertyLoader.load(Config.class, "config.properties");
        PropertyLoader.load(Preset.class, "preset.properties");

        // Start the processing library
        PApplet.main("nl.ronaldvandenbroek.worldgen.WorldGen", args);
    }

    @Override
    public void settings() {
        size(Config.WINDOW_WIDTH, Config.WINDOW_HEIGHT);
    }

    @Override
    public void setup() {
        // Setup exit handler
        Runtime.getRuntime().addShutdownHook(new Thread(this::stop));

        // Setup config variables
        passTime = Config.ENABLE_TIME_LAPSE;

        // Setup utilities
        codeTimer = new CodeTimer("TickSpeed");
        worldGenerator = new WorldGenerator(new SimplexNoise(), new TwoDimensionalArrayUtility());
        processingImageDrawer = new ProcessingImageDrawer(this);

        // Setup GUI
        ControlGui controlGui = new ControlGui(this);
        controlGui.createGUISliderTitle("WorldGen Configuration", true);
        ControlBuilder.menu(controlGui, this);
        if (Config.ENABLE_CONTROLS) {
            ControlBuilder.worldGenControls(controlGui, worldGenerator);
        }

        // Generate the preset map
        codeTimer.start();
        worldGenerator.generateMaps();
        drawMaps();
    }

    @Override
    public void draw() {
        if (passTime) {
            codeTimer.round();
            worldGenerator.incrementCurrentTime();
            worldGenerator.generateMaps();
            drawMaps();
        }
    }

    @Override
    public void stop() {
        codeTimer.end();
    }

    @Override
    public void mouseReleased() {
        worldGenerator.generateMaps();
        drawMaps();
    }

    public void menuPressed(float value) {
        worldGenerator.setCurrentMap(value);
        drawMaps();
    }

    private void drawMaps() {
        PImage displayImage = processingImageDrawer.draw(worldGenerator.finalizeSelectedMap());

        if (displayImage != null) {
            image(displayImage, 0, 0);
        }
    }
}
