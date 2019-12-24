package nl.ronaldvandenbroek.worldgen.processing.gui;

import controlP5.ControlP5;
import nl.ronaldvandenbroek.worldgen.properties.Config;
import processing.core.PApplet;

public class ControlGui {
    private ControlP5 gui;
    private int sliderPosition = 0;
    private int buttonPosition = 0;

    public ControlGui(PApplet processing) {
        gui = new ControlP5(processing);
    }

    public void createGUISliderTitle(String name, boolean first) {
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

    public void createGUIMapButton(ControlElementButton controlElement) {
        gui.addButton(controlElement.getName())
                .setPosition(Config.WIDTH - 80f, buttonPosition)
                .setValue(controlElement.getValue())
                .onRelease(controlElement.getControlListener());
        buttonPosition += 20;
    }
}
