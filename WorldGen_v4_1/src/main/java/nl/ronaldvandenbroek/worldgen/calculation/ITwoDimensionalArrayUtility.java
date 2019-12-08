package nl.ronaldvandenbroek.worldgen.calculation;

public interface ITwoDimensionalArrayUtility {
    /**
     * Merge the two given arrays via linear interpolation
     * Where array 1 and 2 are the same size
     *
     * @param array1 float[][]
     * @param array2 float[][]
     * @param weight float between 0 and 1
     * @return float[][]
     */
    float[][] merge(float[][] array1, float[][] array2, float weight);

    /**
     * Re-map all array values from one range to another
     * Should replace the processing map function: map(array[h][w], initialMin, initialMax, min, max)
     *
     * @param array float[][]
     * @param min   float smaller than max
     * @param max   float
     * @return float[][]
     */
    float[][] map(float[][] array, float min, float max);

    /**
     * Re-map all array values from one range to another
     * Should replace the processing map function: map(array[h][w], initialMin, initialMax, min, max)
     *
     * @param array float[][]
     * @param min   float smaller than max
     * @param max   float
     * @param arrayMin float smaller than max
     * @param arrayMax float
     * @return float[][]
     */
    float[][] map(float[][] array, float min, float max, float arrayMin, float arrayMax);

    /**
     * Curve the array values via powers
     *
     * @param array float[][]
     * @param power float
     * @return float[][]
     */
    float[][] curve(float[][] array, float power);

    /**
     * Create ridges within the array via absolute
     *
     * @param array float[][]
     * @return float[][]
     */
    float[][] ridge(float[][] array);

    /**
     * Add percentile circular falloff to the array
     *
     * @param array           float[][]
     * @param falloffStrength float
     * @return float[][]
     */
    float[][] circularFalloffPercentile(float[][] array, float falloffStrength);

    /**
     * Add absolute circular falloff to the array
     *
     * @param array           float[][]
     * @param falloffStrength float
     * @return float[][]
     */
    float[][] circularFalloffAbsolute(float[][] array, float falloffStrength);

    float[][] verticalFalloffAbsolute(float[][] array, int offset);

    /**
     * Calculate the percentage of the way to the border of the grid you are from any given point
     *
     * @param h               int
     * @param w               int
     * @param centerHeight    int
     * @param centerWidth     int
     * @param falloffStrength float
     * @return double
     */
    double calculateDistancePercentage(int h, int w, int centerHeight, int centerWidth, float falloffStrength);

    /**
     * Get the highest value in the 2D array
     *
     * @param array float[][]
     * @return float
     */
    float getHighestArrayValue(float[][] array);

    /**
     * Get the lowest value in the 2D array
     *
     * @param array float[][]
     * @return float
     */
    float getLowestArrayValue(float[][] array);

    /**
     * Get the height (amount of rows) of the array
     *
     * @param array float[][]
     * @return int
     */
    int getArrayHeight(float[][] array);

    /**
     * Get the width (amount of columns) of the array
     *
     * @param array float[][]
     * @return int
     */
    int getArrayWidth(float[][] array);
}
