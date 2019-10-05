package nl.ronaldvandenbroek.worldgen.gui;

import controlP5.CallbackEvent;
import controlP5.CallbackListener;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class ControlListener implements CallbackListener {
    private Method callBackMethod;
    private Object callBackObject;

    public ControlListener(Method callBackMethod, Object callbackObject) {
        this.callBackMethod = callBackMethod;
        this.callBackObject = callbackObject;
    }

    @Override
    public void controlEvent(CallbackEvent callbackEvent) {
        try {
            System.out.println(callbackEvent.getController().getValue());
            callBackMethod.invoke(callBackObject, callbackEvent.getController().getValue());
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }
}
