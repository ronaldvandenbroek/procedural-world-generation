package nl.ronaldvandenbroek.worldgen.processing;

import processing.core.PImage;

public interface IProcessingImageDrawer {
    PImage draw(float[][] array);
}
