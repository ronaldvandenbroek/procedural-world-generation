package nl.ronaldvandenbroek.worldgen.utility;

public class Utility {
    private Utility() {
    }

    public static String upperCaseFirst(String value) {
        char[] array = value.toCharArray();
        array[0] = Character.toUpperCase(array[0]);
        return new String(array);
    }
}
