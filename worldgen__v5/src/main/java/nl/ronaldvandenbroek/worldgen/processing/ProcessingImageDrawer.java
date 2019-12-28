package nl.ronaldvandenbroek.worldgen.processing;

import nl.ronaldvandenbroek.worldgen.properties.Config;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PImage;

public class ProcessingImageDrawer implements IProcessingImageDrawer {
    private PApplet processing;

    public ProcessingImageDrawer(PApplet processing) {
        this.processing = processing;
    }

    @Override
    public PImage draw(float[][] array) {
        int arrayHeight = array.length;
        int arrayWidth = array[0].length;

        PImage image = processing.createImage(arrayHeight, arrayWidth, PConstants.RGB);
        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                if (array[h][w] < 120) {
                    image.pixels[h * arrayWidth + w] = processing.color(0, 0, 255);
                } else {
                    image.pixels[h * arrayWidth + w] = processing.color(array[h][w]);
                }
            }
        }
        image.resize(Config.WINDOW_WIDTH,Config.WINDOW_HEIGHT);
        processing.getSurface().setTitle(processing.frameRate + " fps");
        return image;
    }
}

