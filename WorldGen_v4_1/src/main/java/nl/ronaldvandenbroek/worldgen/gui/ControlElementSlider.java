package nl.ronaldvandenbroek.worldgen.gui;

import nl.ronaldvandenbroek.worldgen.Utility;

class ControlElementSlider {
    private ControlListener controlListener;
    private String name;
    private float defaultValue;
    private float min;
    private float max;

    ControlElementSlider(String displayName, String variableName, Object variableLocation, float defaultValue, float min, float max) {
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

    ControlListener getControlListener() {
        return controlListener;
    }

    String getName() {
        return name;
    }

    float getMin() {
        return min;
    }

    float getMax() {
        return max;
    }

    float getDefaultValue() {
        return defaultValue;
    }
}
