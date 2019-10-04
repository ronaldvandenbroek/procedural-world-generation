package nl.ronaldvandenbroek.worldgen.gui;

import controlP5.CallbackEvent;
import controlP5.CallbackListener;
import controlP5.ControlP5;
import nl.ronaldvandenbroek.worldgen.WorldGen;
import processing.core.PImage;

import static processing.core.PConstants.RGB;

public class ControlGui {
    private int sliderPosition = 0;
    private int buttonPosition = 0;
    private boolean guiShow = true;
    private int currentMap = 0;

    public static ControlP5 gui;

    public ControlGui() {
        gui = new ControlP5(WorldGen.processing);
        createGUISliderTitle("HeightMap Configuration", true);
        createGUISlider("intensity1", 1, 30);
        createGUISlider("power1", 0, 50);
        createGUISlider("falloff1", 0, 10);
        createGUISlider("octaves1", 1, 15);
        createGUISlider("circularFalloff1", 0, 1);
        createGUISlider("blendPower12", 0, 1);
        createGUISlider("intensity2", 1, 30);
        createGUISlider("power2", 0, 50);
        createGUISlider("falloff2", 0, 10);
        createGUISlider("octaves2", 1, 15);
        createGUISlider("circularFalloff2", 0, 1);

        createGUISliderTitle("Sealevel Configuration", false);
        createGUISlider("seaLevel", 0, 255);

        createGUISliderTitle("TemperatureMap Configuration", false);
        createGUISlider("equatorOffset", -WorldGen.processing.height/2, WorldGen.processing.height/2);
        createGUISlider("temperatureFalloff", 0, 1);
        createGUISlider("temperatureHeight", 0, 1);

        createGUISliderTitle("HumidityMap Configuration", false);
        createGUISlider("rainDirection1", 0, 8);
        createGUISlider("rainDirection1Strength", 0, 10);
        createGUISlider("rainDirection2", 0, 8);
        createGUISlider("rainDirection2Strength", 0, 10);
        createGUISlider("rainDirection3", 0, 8);
        createGUISlider("rainDirection3Strength", 0, 10);

        CallbackListener exportCallbackListener = new CallbackListener() {
            public void controlEvent(CallbackEvent theEvent) {

            }
        };
        CallbackListener mapCallbackListener = new CallbackListener() {
            public void controlEvent(CallbackEvent theEvent) {
                int buttonPressed = (int)theEvent.getController().getValue();
                currentMap = buttonPressed;
                //drawMap(buttonPressed);
            }
        };

        createGUIMapButton("Height Map", 0, mapCallbackListener);
        createGUIMapButton("Temperature Map", 1, mapCallbackListener);
        createGUIMapButton("Humidity Map", 2, mapCallbackListener);
        createGUIMapButton("Biome Map", 3, mapCallbackListener);

        createGUIMapButton("Export", -1, exportCallbackListener);
    }

    public void createGUISliderTitle(String name, Boolean first) {
        if (!first) {
            sliderPosition += 10;
        }
        gui.addLabel(name).setPosition(0, sliderPosition);
        sliderPosition += 10;
    }

    public void createGUISlider(String name, int min, int max) {
        gui.addSlider(name).setPosition(0, sliderPosition).setRange(min, max);
        sliderPosition += 10;
    }

    public void createGUIMapButton(String name, int value, CallbackListener callbackListener) {
        gui.addButton(name).setPosition(WorldGen.processing.width - 80, buttonPosition).setValue(value).onRelease(callbackListener);
        buttonPosition += 20;
    }
}
