package nl.ronaldvandenbroek.worldgen.gui;

import nl.ronaldvandenbroek.worldgen.Utility;

import java.lang.reflect.Method;

public class ControlElementSliderInteger {
    private ControlListener controlListener;
    private String name;
    private int defaultValue;
    private int min;
    private int max;

    public ControlElementSliderInteger(String displayName, String variableName, Object variableLocation, int defaultValue, int min, int max) {
        try {
            this.name = displayName;
            this.defaultValue = defaultValue;
            this.min = min;
            this.max = max;
            controlListener = new ControlListener(variableLocation.getClass().getMethod("set" + Utility.upperCaseFirst(variableName), float.class), variableLocation);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
    }

    public ControlListener getControlListener() {
        return controlListener;
    }

    public String getName(){
        return name;
    }

    public int getMin(){
        return min;
    }

    public int getMax(){
        return max;
    }

    public int getDefaultValue() {
        return defaultValue;
    }
}
