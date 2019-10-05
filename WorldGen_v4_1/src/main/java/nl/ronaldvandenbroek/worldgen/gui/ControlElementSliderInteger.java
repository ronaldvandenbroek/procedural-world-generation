package nl.ronaldvandenbroek.worldgen.gui;

import java.lang.reflect.Method;

public class ControlElementSliderInteger {
    private ControlListener controlListener;
    private String name;
    private int min;
    private int max;

    public ControlElementSliderInteger(String name, Method callbackMethod, int min, int max, Presets presets) {
        this.name = name;
        this.min = min;
        this.max = max;

        controlListener = new ControlListener(callbackMethod, presets);
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
}
