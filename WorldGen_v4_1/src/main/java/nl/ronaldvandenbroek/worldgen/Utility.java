package nl.ronaldvandenbroek.worldgen;

public class Utility {
    public static String upperCaseFirst(String value) {
        char[] array = value.toCharArray();
        array[0] = Character.toUpperCase(array[0]);
        return new String(array);
    }
}
