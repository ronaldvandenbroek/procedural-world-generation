package nl.ronaldvandenbroek.worldgen.properties;

public class Preset {
    private Preset() {
    }

    public static String HEIGHT_MAP_BASE_NAME;
    public static int HEIGHT_MAP_BASE_SEED;
    public static int HEIGHT_MAP_BASE_OCTAVE;
    public static float HEIGHT_MAP_BASE_NOISE_FALLOFF;
    public static float HEIGHT_MAP_BASE_INTENSITY;
    public static boolean HEIGHT_MAP_BASE_RIDGE;
    public static float HEIGHT_MAP_BASE_POWER;
    public static float HEIGHT_MAP_BASE_CIRCULAR_FALLOFF;
    public static float HEIGHT_MAP_BASE_WEIGHT;

    public static String HEIGHT_MAP_RIDGE_NAME;
    public static int HEIGHT_MAP_RIDGE_SEED;
    public static int HEIGHT_MAP_RIDGE_OCTAVE;
    public static float HEIGHT_MAP_RIDGE_NOISE_FALLOFF;
    public static float HEIGHT_MAP_RIDGE_INTENSITY;
    public static boolean HEIGHT_MAP_RIDGE_RIDGE;
    public static float HEIGHT_MAP_RIDGE_POWER;
    public static float HEIGHT_MAP_RIDGE_CIRCULAR_FALLOFF;
    public static float HEIGHT_MAP_RIDGE_WEIGHT;

    public static float HEIGHT_MAP_TOTAL_CIRCULAR_FALLOFF;

    public static int TEMPERATURE_MAP_EQUATOR_OFFSET;
    public static float TEMPERATURE_MAP_GLOBAL_MODIFIER;
    public static float TEMPERATURE_MAP_LATITUDE_STRENGTH;
    public static float TEMPERATURE_MAP_ALTITUDE_STRENGTH;
}
