package nl.ronaldvandenbroek.worldgen.gui;

import nl.ronaldvandenbroek.worldgen.Utility;

public class ControlElementSlider {
    private ControlListener controlListener;
    private String name;
    private float defaultValue;
    private float min;
    private float max;

    public ControlElementSlider(String displayName, String variableName, Object variableLocation, float defaultValue, float min, float max) {
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

    public float getMin(){
        return min;
    }

    public float getMax(){
        return max;
    }

    public float getDefaultValue() {
        return defaultValue;
    }
}
