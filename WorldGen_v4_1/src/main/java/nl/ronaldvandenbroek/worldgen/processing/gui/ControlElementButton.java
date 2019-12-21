package nl.ronaldvandenbroek.worldgen.processing.gui;

class ControlElementButton {
    private ControlListener controlListener;
    private String name;
    private float value;

    ControlElementButton(String displayName, Object variableLocation, float value) {
        try {
            this.name = displayName;
            this.value = value;
            controlListener = new ControlListener(variableLocation.getClass().getMethod("menuPressed", float.class), variableLocation);
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

    float getValue() {
        return value;
    }
}
