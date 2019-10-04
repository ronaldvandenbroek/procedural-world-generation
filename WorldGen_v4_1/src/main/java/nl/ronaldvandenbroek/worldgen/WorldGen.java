package nl.ronaldvandenbroek.worldgen;

import controlP5.ControlP5;
import nl.ronaldvandenbroek.worldgen.gui.ControlGui;
import processing.core.PApplet;

public class WorldGen extends PApplet {
    public static PApplet processing;
    public static ControlP5 gui;

    public static void main(String[] args) {
        PApplet.main("nl.ronaldvandenbroek.worldgen.WorldGen", args);
    }

    public void settings() {
        size(1024, 1024);
    }

    public void setup(){
        processing = this;
        new ControlGui();
    }

    public void draw() {
        line(5,5,10,10);
    }
}
