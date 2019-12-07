package nl.ronaldvandenbroek.worldgen.gui;

import controlP5.ControlP5;
import processing.core.PApplet;

public class ControlGui {
    private int sliderPosition = 0;
    private PApplet processing;

    public static ControlP5 gui;

    public ControlGui(PApplet processing) {
        this.processing = processing;
        gui = new ControlP5(processing);
    }

    public void createGUISliderTitle(String name, Boolean first) {
        if (!first) {
            sliderPosition += 10;
        }
        gui.addLabel(name).setPosition(0, sliderPosition);
        sliderPosition += 10;
    }

    public void createGUISlider(ControlElementSlider controlElement) {
        gui.addSlider(controlElement.getName())
                .setPosition(0, sliderPosition)
                .setRange(controlElement.getMin(), controlElement.getMax())
                .setValue(controlElement.getDefaultValue())
                .onRelease(controlElement.getControlListener());
        sliderPosition += 10;
    }
}
